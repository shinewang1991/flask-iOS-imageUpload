//
//  LoginViewController.m
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import "LoginViewController.h"
#import "BLL.h"

@interface LoginViewController ()

@property (nonatomic, weak) IBOutlet UITextField *usernameFld;
@property (nonatomic, weak) IBOutlet UITextField *passwordFld;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)Login:(id)sender
{
    NSString *username = self.usernameFld.text;
    NSString *password = self.passwordFld.text;
    [[BLL sharedInstance] loginWithEmail:username andPassword:password success:^(NSObject *object) {
        //
    } falure:^(NSError *error) {
        //
    }];
}

@end
