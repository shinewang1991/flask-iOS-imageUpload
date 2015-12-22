//
//  User.h
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@interface UserModel : BaseModel

@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *password;
@property (copy, nonatomic) NSString *email;
@property (copy, nonatomic) NSString *token;
@end
