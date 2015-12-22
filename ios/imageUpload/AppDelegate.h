//
//  AppDelegate.h
//  imageUpload
//
//  Created by Shine on 12/12/15.
//  Copyright © 2015 Shine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LoginViewController.h"
#import "HomeViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) HomeViewController *homeViewController;


@end

