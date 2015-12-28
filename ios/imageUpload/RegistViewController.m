//
//  RegistViewController.m
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import "RegistViewController.h"
#import "AppDelegate.h"
#import "BLL.h"
#import "MPTTips.h"

@interface RegistViewController ()

@property (nonatomic, weak) IBOutlet UITextField *usernameFld;
@property (nonatomic, weak) IBOutlet UITextField *passwordFld;

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)register:(id)sender
{
    NSString *username = self.usernameFld.text;
    NSString *password = self.passwordFld.text;
    [[BLL sharedInstance] registWithEmail:username andPassword:password success:^(BOOL success) {
        
        [MPTTips showTips:@"register success" duration:1.f];
    } falure:^(NSError *error) {
        
        [MPTTips showTips:@"register failed" duration:1.f];
    }];

}

- (IBAction)gotoLogin:(id)sender
{
    
    [UIView transitionWithView:[AppDelegate sharedInstance].window duration:0.5
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        [AppDelegate sharedInstance].window.rootViewController = [AppDelegate sharedInstance].loginViewController;
                    }
                    completion:nil];
}


@end
