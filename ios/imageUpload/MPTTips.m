//
//  MPTTips.m
//  MPTBase
//
//  Created by Jeakin on 11/28/14.
//  Copyright (c) 2014 Jeakin. All rights reserved.
//

#import "MPTTips.h"

@implementation MPTTips

void showAlertChoiceWithDelegate(NSString*text, id <UIAlertViewDelegate> delegate, int tag)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:text message:@"" delegate:delegate cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = tag;
    [alert show];
    
}

void showAlertReversionChoiceWithDelegate(NSString*text, id <UIAlertViewDelegate> delegate, int tag)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:text message:@"" delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
    alert.tag = tag;
    [alert show];
    
}

void showAlertOKWithDelegate(NSString*text, id <UIAlertViewDelegate> delegate, int tag)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:text message:@"" delegate:delegate cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag = tag;
    [alert show];
}

void showAlert(NSString*text)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:text message:@"" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    
}

+ (MBProgressHUD *)showProgressTips:(NSString *)title {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = title;
    return hud;
}

+ (void)showTips:(NSString *)title duration:(CGFloat)duration {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.detailsLabelText = title;
    hud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
    hud.mode = MBProgressHUDModeText;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES];
    });
}

+ (void)showSingleTips:(NSString *)title duration:(CGFloat)duration {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window) {
        [MBProgressHUD hideAllHUDsForView:window animated:NO];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.detailsLabelText = title;
        hud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
        hud.mode = MBProgressHUDModeText;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES];
        });
    }
}

+ (void)showSingleTips:(NSString *)title duration:(CGFloat)duration offsetY:(CGFloat)offset {
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window) {
        [MBProgressHUD hideAllHUDsForView:window animated:NO];
        
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
        hud.detailsLabelText = title;
        hud.detailsLabelFont = [UIFont systemFontOfSize:16.0f];
        hud.mode = MBProgressHUDModeText;
        hud.yOffset = offset;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES];
        });
    }
}

+ (void)showTips:(NSString *)title image:(UIImage *)image duration:(CGFloat)duration {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = [[UIImageView alloc] initWithImage:image];
    hud.labelText = title;
    hud.mode = MBProgressHUDModeCustomView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES];
    });
}

+ (void)showTipsView:(UIView *)customView duration:(CGFloat)duration {
    UIView *view = [UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.customView = customView;
    hud.mode = MBProgressHUDModeCustomView;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES];
    });
}

+ (NSString *)getNumWith:(NSInteger)num
{
    if(num < 10000){
        return @(num).stringValue;
        //        return [NSString stringWithFormat:@"%d",num];
    }else if (num < 100000){
        return [NSString stringWithFormat:@"%.1f万",(num/10000.0)];
    }else if (num < 1000000){
        return  [NSString stringWithFormat:@"%.1f万",(num/10000.0)];
    }else if(num < 100000000){
        return  [NSString stringWithFormat:@"%.1f万",(num/10000.0)];
    }else{
        return [NSString stringWithFormat:@"%.1f亿",(num/100000000.0)];
    }
}

BOOL AllTextIsSpace(NSString * str)
{
    int allIsSpaces = YES;
    
    for (int i=0; i<[str length]; i++) {
        unichar xx = [str characterAtIndex:i];
        if (xx != ' ') {
            allIsSpaces = NO;
        }
    }
    
    return allIsSpaces;
}

NSString* getAppVersion()
{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"/*(NSString *)kCFBundleVersionKey*/];
    return version;
};


@end
