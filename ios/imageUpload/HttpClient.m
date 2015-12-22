//
//  HttpClient.m
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import "HttpClient.h"

static NSString *const KApiBaseUrlS = @"http://10.10.69.15:5000";

@implementation HttpClient


+ (HttpClient *)sharedHTTPClient
{
    static HttpClient *_sharedHTTPClient = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedHTTPClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:KApiBaseUrlS]];
    });
    
    return _sharedHTTPClient;

}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    
    self = [super initWithBaseURL:url];
    
    if (self) {
         self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", @"text/plain", nil];
        
        [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    }
    
    return self;
    
}


- (AFHTTPRequestOperation *)postPath:(NSString *)path
                          parameters:(NSDictionary *)parameters
                       queuePriority:(NSOperationQueuePriority)queuePriority
                             success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                             failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString] parameters:parameters error:nil];

     AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject) {
         
          success(operation, responseObject);
         
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         failure(operation, error);
     }];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}
@end
