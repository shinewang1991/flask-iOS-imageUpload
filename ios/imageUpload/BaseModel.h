//
//  BaseModel.h
//  imageUpload
//
//  Created by wangxiang on 15/12/22.
//  Copyright © 2015年 Shine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"
@interface BaseModel :MTLModel<MTLJSONSerializing>

+ (instancetype) fromJSONDictionary:(NSDictionary *)JSONDictionary error:(NSError **)error;

+ (NSArray *) fromJSONArray:(NSArray *)JSONArray error:(NSError **)error;
@end
