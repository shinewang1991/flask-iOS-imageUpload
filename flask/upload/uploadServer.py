 #coding:utf-8
from flask import Flask, jsonify, request,url_for,send_from_directory, g, abort, render_template
from flask.ext.sqlalchemy import SQLAlchemy
from flask.ext.bootstrap import Bootstrap
from werkzeug import secure_filename
from passlib.apps import custom_app_context as pwd_context
from flask.ext.httpauth import HTTPBasicAuth
from itsdangerous import TimedJSONWebSignatureSerializer as Serializer, BadSignature, SignatureExpired
import os

basedir = os.path.abspath(os.path.dirname(__file__))
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///' + os.path.join(basedir,'image.db')
app.config['SECRET_KEY'] = 'shine_test'
db = SQLAlchemy(app)
bootstrap = Bootstrap(app)
auth = HTTPBasicAuth()

class Image(db.Model):
	__tablename__ = 'Image'
	id = db.Column(db.Integer, primary_key = True)
	url = db.Column(db.String(100))

	def __init__(self,url):
		self.url = url;

class User(db.Model):
    __tablename__ = 'Users'
    id = db.Column(db.Integer,primary_key = True)
    username = db.Column(db.String(32), index = True)
    password_hash = db.Column(db.String(128))

    def hash_password(self,password):
        self.password_hash = pwd_context.encrypt(password)

    def verify_password(self,password):
        return pwd_context.verify(password,self.password_hash)
    def generate_auth_token(self, expiration=600):
        s = Serializer(app.config['SECRET_KEY'], expires_in=expiration)
        return s.dumps({'id': self.id}).decode('ascii')
    @staticmethod
    def verify_auth_token(token):
        s = Serializer(app.config['SECRET_KEY'])
        try:
            data = s.loads(token)
        except SignatureExpired:
            return None  #valid token, but expired
        except BadSignature:
            return None #invalid token
        user = User.query.get(data['id'])
        return user


UPLOAD_FOLDER = './uploads'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

@auth.verify_password
def verify_password(username_or_token,password):
    user = User.verify_auth_token(username_or_token)
    if not user:
        user = User.query.filter_by(username = username_or_token).first()
        if not user or not user.verify_password(password):
            return False
    g.user = user
    return True

@app.route('/api/token')
@auth.login_required
def get_auth_token():
    token = g.user.generate_auth_token()
    return jsonify({'token':token.decode('ascii')})

#首页
@app.route('/',methods = ['GET','POST'])
@app.route('/home',methods = ['GET','POST'])
@auth.login_required
def mainPage():
    return render_template('base.html'), 200

@app.route('/home/<name>')
@auth.login_required
def homePage(name):
    return render_template('user.html',name = name)

@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404

@app.errorhandler(500)
def internal_server_error(e):
    return render_template('500.html'), 500


#上传图片
@app.route('/upload',methods = ['POST'])
def upload():
	imagefile = request.files.get('avatar', '')
	filename = secure_filename(imagefile.filename)
	filePath = os.path.join(app.config['UPLOAD_FOLDER'],filename)
	if(os.path.isfile(filePath)):
		# return jsonify({'status':'file already exist'}),200
		return redirect(url_for('uploaded_file',filename = filename))
	else:
		#save to db
		image = Image(url_for('uploaded_file',filename = filename,_external = True))
		db.session.add(image)
		db.session.commit()

		imagefile.save(filePath)
		return jsonify({'status':'success'}), 200

#注册
@app.route('/users/register', methods = ['POST'])
def login():
    username = request.json.get('username')
    password = request.json.get('password')
    if username is None or password is None:
        abort(400)
    if User.query.filter_by(username = username).first() is not None:
        abort(400)

    user = User(username = username)
    user.hash_password(password)
    db.session.add(user)
    db.session.commit()
    return jsonify({'status':'success'})

#登录
@app.route('/users/login', methods = ['POST'])
def login():
    username = request.json.get('username')
    password = request.json.get('password')
    if username is None or password is None:
        abort(400)
    if User.query.filter_by(username = username).first() is not None:
        abort(400)

    user = User(username = username)
    user.hash_password(password)
    db.session.add(user)
    db.session.commit()
    return jsonify({'status':'success'})


#获取资源列表
@app.route('/upload',methods = ['GET'])
@auth.login_required
def getResources():
	imageArray = Image.query.all()
	urls = []
	print('start print')
	for image in imageArray:
		urls.append(image.url)
		
	# for f in os.listdir(UPLOAD_FOLDER):
	# 	if f.endswith(".JPG"):
	# 		url = url_for('uploaded_file',filename = f,_external = True)
	# 		imageArray.append(url)
	return jsonify({'status':'success','data':urls})

#获取单个资源
@app.route('/uploads/<filename>')
@auth.login_required
def uploaded_file(filename):
	return send_from_directory(app.config['UPLOAD_FOLDER'],filename)

if __name__ == '__main__':
	db.create_all()
	
	app.run(debug = True, host = '0.0.0.0')