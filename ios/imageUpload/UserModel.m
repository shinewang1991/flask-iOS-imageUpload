//
//  User.m
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel
+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"username":@"username",
             @"password":@"password",
             @"email":@"email",
             @"token":@"token",
             };
}

@end
