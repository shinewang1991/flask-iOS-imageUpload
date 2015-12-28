//
//  AppDelegate.m
//  imageUpload
//
//  Created by Shine on 12/12/15.
//  Copyright © 2015 Shine. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

+ (instancetype)sharedInstance
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

- (RegistViewController *)registerController
{
    if(_registerController == nil)
    {
        _registerController = [[RegistViewController alloc] init];
    }
    
    return _registerController;
}

- (LoginViewController *)loginViewController
{
    if(_loginViewController == nil)
    {
        _loginViewController = [[LoginViewController alloc] init];
    }
    
    return _loginViewController;

}

- (HomeViewController *)homeViewController
{
    if(_homeViewController == nil)
    {
        _homeViewController = [[HomeViewController alloc] init];
        
    }
    
    return _homeViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if([[NSUserDefaults standardUserDefaults] objectForKey:@"user_Token"])  //有Token则进入主页
    {
        HomeViewController *home = [[HomeViewController alloc] init];
        self.homeViewController = home;
        self.window.rootViewController = self.homeViewController;
    }
    else
    {
        self.window.rootViewController = self.loginViewController;
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
