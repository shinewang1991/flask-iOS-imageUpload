//
//  ViewController.m
//  imageUpload
//
//  Created by Shine on 12/12/15.
//  Copyright © 2015 Shine. All rights reserved.
//

#import "ViewController.h"
#import <AFNetworking.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface ViewController ()

@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *statusLbl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickImage
{
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
    NSURL *refURL = [info valueForKey:UIImagePickerControllerReferenceURL];
    
    
    __weak typeof (self) weakSelf = self;
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *imageAsset)
    {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        ALAssetRepresentation *imageRep = [imageAsset defaultRepresentation];
        NSLog(@"[imageRep filename] : %@", [imageRep filename]);
        
        strongSelf.selectedImage = image;
        strongSelf.imageName = [imageRep filename];
        self.imgView.image = image;
    };
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:refURL resultBlock:resultblock failureBlock:nil];
    
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}


- (IBAction)upload
{
    if(!self.selectedImage)
    {
        return;
    }
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:@"http://192.168.31.114:5000"]];
    
    NSData *imageData = UIImageJPEGRepresentation(self.selectedImage, 1.0);
    
    NSMutableURLRequest *request = [manager.requestSerializer
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:@"http://192.168.31.114:5000/upload"
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData appendPartWithFileData:imageData
                                                                    name:@"avatar"
                                                                fileName:self.imageName
                                                                mimeType:@"image/jpeg"];
                                    }
                                    error:nil];
    
    __weak typeof (self) weakSelf = self;
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        NSLog(@"success. upload,%@", responseObject);
        strongSelf.statusLbl.text = @"upload success";
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        NSLog(@"failure. upload....");
        strongSelf.statusLbl.text = @"upload failed";
    }];
    [manager.operationQueue addOperation:operation];
    
}


@end
