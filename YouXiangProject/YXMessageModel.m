//
//  YXMessageModel.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/3.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXMessageModel.h"

@implementation YXMessageModel


+ (NSArray *)getModelsFromArray:(NSArray *)array
{
    NSMutableArray * result = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        YXMessageModel * model =  [[YXMessageModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dict];
        
        for (NSString * key in dict) {
            id obj = dict[key];
            if ([obj isKindOfClass:[NSNumber class]]) {
                [model setValue:[obj stringValue] forKey:key];
                
            }
        }
        
        NSDictionary * userinfo = dict[@"userinfo"];
        [model setValuesForKeysWithDictionary:userinfo];
        
        NSDictionary * msginfo = dict[@"msginfo"];
        [model setValuesForKeysWithDictionary:msginfo];
        
        [result addObject:model];
    }
    
    return result;
}


@end
