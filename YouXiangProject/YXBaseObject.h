//
//  YXBaseObject.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/27.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXBaseObject : NSObject

+ (NSArray *)getModelsFromArray:(NSArray *)array;
+ (NSArray *)getModelsFromDict:(NSDictionary *)dict;
+ (id )getModelWithDict:(NSDictionary *)dict;
@end
