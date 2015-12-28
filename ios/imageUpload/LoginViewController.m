//
//  LoginViewController.m
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import "LoginViewController.h"
#import "BLL.h"
#import "AppDelegate.h"
#import "MPTTips.h"
#import "UserModel.h"

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
    [[BLL sharedInstance] loginWithEmail:username andPassword:password success:^(BOOL result, NSObject *object) {
        if(result)
        {
            [MPTTips showTips:@"login success" duration:1.f];
            
            UserModel *userModel =  (UserModel *)object;
            NSString *userToken = userModel.token;
            [[NSUserDefaults standardUserDefaults] setValue:userToken forKey:@"User-Token"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            [AppDelegate sharedInstance].window.rootViewController = [AppDelegate sharedInstance].homeViewController;
        }
        else
        {
            [MPTTips showTips:@"login failed" duration:1.f];
        }
    } falure:^(NSError *error) {
        
        [MPTTips showTips:@"login failed" duration:1.f];
    }];
}

- (IBAction)gotoRegister:(id)sender
{
    
    [UIView transitionWithView:[AppDelegate sharedInstance].window duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [AppDelegate sharedInstance].window.rootViewController = [AppDelegate sharedInstance].registerController;
                    }
                    completion:nil];
   }

@end
