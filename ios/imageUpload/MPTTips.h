//
//  MPTTips.h
//  MPTBase
//
//  Created by Jeakin on 11/28/14.
//  Copyright (c) 2014 Jeakin. All rights reserved.
//

#import "MPTObject.h"
#import "MBProgressHUD.h"
#import <UIKit/UIKit.h>

@interface MPTTips : MPTObject

void showAlertChoiceWithDelegate(NSString*text, id <UIAlertViewDelegate> delegate, int tag);
void showAlertReversionChoiceWithDelegate(NSString*text, id <UIAlertViewDelegate> delegate, int tag);
void showAlertOKWithDelegate(NSString*text, id <UIAlertViewDelegate> delegate, int tag);

void showAlert(NSString*text);

+ (MBProgressHUD *)showProgressTips:(NSString *)title ;
+ (void)showTips:(NSString *)title duration:(CGFloat)duration ;
+ (void)showSingleTips:(NSString *)title duration:(CGFloat)duration offsetY:(CGFloat)offset;
+ (void)showTips:(NSString *)title image:(UIImage *)image duration:(CGFloat)duration;
+ (void)showTipsView:(UIView *)customView duration:(CGFloat)duration;
+ (void)showSingleTips:(NSString *)title duration:(CGFloat)duration;

+ (NSString *)getNumWith:(NSInteger)num;
BOOL AllTextIsSpace(NSString * str);
NSString* getAppVersion();


@end
