//
//  BLL.h
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLL : NSObject

+ (instancetype)sharedInstance;

- (void)registWithEmail:(NSString *)email andPassword:(NSString *)password success:(void (^)(BOOL success))sucesssBlock falure:(void(^)(NSError *error))failureBlock;

- (void)loginWithEmail:(NSString *)email andPassword:(NSString *)password success:(void (^)(NSObject *object))sucesssBlock falure:(void(^)(NSError *error))failureBlock;
@end
