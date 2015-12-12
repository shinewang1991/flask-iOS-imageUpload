from flask import Flask, jsonify, request
from werkzeug import secure_filename
import os

app = Flask(__name__)

UPLOAD_FOLDER = './uploads'
ALLOWED_EXTENSIONS = set(['txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif'])
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER 

@app.route('/',methods = ['GET','POST'])
def mainPage():
	return 'Hello World'

@app.route('/upload',methods = ['POST'])
def upload():
	imagefile = request.files.get('avatar', '')
	filename = secure_filename(imagefile.filename)
	filePath = os.path.join(app.config['UPLOAD_FOLDER'],filename)
	if(os.path.isfile(filePath)):
		return jsonify({'status':'file already exist'}),200
	else:
		imagefile.save(filePath)
		return jsonify({'status':'success'}), 200



if __name__ == '__main__':
	app.run(debug = True, host = '0.0.0.0')