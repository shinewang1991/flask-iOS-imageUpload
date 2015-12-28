//
//  HomeViewController.m
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//


#import "HomeViewController.h"
#import "HttpClient.h"

#import <AFNetworking.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface HomeViewController ()

@property (nonatomic, strong) UIImage *selectedImage;
@property (nonatomic, strong) NSString *imageName;
@property (nonatomic, weak) IBOutlet UIImageView *imgView;
@property (nonatomic, weak) IBOutlet UILabel *statusLbl;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:KApiBaseUrlS]];
    
    NSData *imageData = UIImageJPEGRepresentation(self.selectedImage, 1.0);
    
    NSMutableURLRequest *request = [manager.requestSerializer
                                    multipartFormRequestWithMethod:@"POST"
                                    URLString:[NSString stringWithFormat:@"%@/upload",KApiBaseUrlS]
                                    parameters:nil
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        [formData appendPartWithFileData:imageData
                                                                    name:@"avatar"
                                                                fileName:self.imageName
                                                                mimeType:@"image/jpeg"];
                                    }
                                    error:nil];
    NSString *userToken = [[NSUserDefaults standardUserDefaults] valueForKey:@"User-Token"];
    [request addValue:userToken forHTTPHeaderField:@"username_or_token"];
    [request addValue:@"" forHTTPHeaderField:@"password"];
    
    __weak typeof (self) weakSelf = self;
    AFHTTPRequestOperation *operation = [manager HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        NSLog(@"success. upload,%@", responseObject);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        __strong typeof (weakSelf) strongSelf = weakSelf;
        NSLog(@"failure. upload....");
        strongSelf.statusLbl.text = @"upload failed";
    }];
    [manager.operationQueue addOperation:operation];
    
}


@end
