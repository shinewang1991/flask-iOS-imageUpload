//
//  BaseModel.m
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel


+ (instancetype) fromJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error {
    return [MTLJSONAdapter modelOfClass:[self class] fromJSONDictionary:JSONDictionary error:error];
}

+ (NSArray *) fromJSONArray:(NSArray *)JSONArray error:(NSError **)error  {
    return [MTLJSONAdapter modelsOfClass:[self class] fromJSONArray:JSONArray error:error];
}

@end
