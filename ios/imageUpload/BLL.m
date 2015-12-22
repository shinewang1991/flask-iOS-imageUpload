//
//  BLL.m
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import "BLL.h"
#import "UserModel.h"
#import "HttpClient.h"

@implementation BLL
+ (instancetype)sharedInstance
{
    static BLL *_Bll = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _Bll = [[self alloc] init];
    });
    
    return _Bll;
}

- (NSDictionary *)buildParameters;
{
    return [NSDictionary dictionary];
}
- (void)registWithEmail:(NSString *)email andPassword:(NSString *)password success:(void (^)(BOOL success))sucesssBlock falure:(void(^)(NSError *error))failureBlock
{
    NSDictionary * parameters = @{@"username":email,@"password":password};
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[HttpClient sharedHTTPClient] POST:@"/users/register" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"status"] integerValue] == 200)
            {
                sucesssBlock(YES);
                
            }
            else
            {
                sucesssBlock(NO);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            failureBlock(error);
        }];
    });

}

- (void)loginWithEmail:(NSString *)email andPassword:(NSString *)password success:(void (^)(NSObject *object))sucesssBlock falure:(void(^)(NSError *error))failureBlock
{
    NSDictionary * parameters = @{@"username":email,@"password":password};
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [[HttpClient sharedHTTPClient] POST:@"/users/login" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if([[responseObject objectForKey:@"status"] integerValue] == 200)
            {
                NSError *error = nil;

                UserModel *user = [UserModel fromJSONDictionary:responseObject[@"result"] error:&error];
                sucesssBlock(user);
                
            }
            else
            {
                sucesssBlock(nil);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            failureBlock(error);
        }];
    });
}
@end
