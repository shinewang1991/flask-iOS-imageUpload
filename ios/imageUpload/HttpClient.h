//
//  HttpClient.h
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface HttpClient : AFHTTPRequestOperationManager

+ (HttpClient *)sharedHTTPClient;
@end
