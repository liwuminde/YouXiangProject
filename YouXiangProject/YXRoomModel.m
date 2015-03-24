//
//  YXRoomModel.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXRoomModel.h"

@implementation YXRoomModel

+ (NSArray *)getModelsFromArray:(NSArray *)array
{
    NSMutableArray * result = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        YXRoomModel * model =  [[YXRoomModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dict];
        
        for (NSString * key in dict) {
            id obj = dict[key];
            if ([obj isKindOfClass:[NSNumber class]]) {
                [model setValue:[obj stringValue] forKey:key];
                
            }
        }
        
        NSDictionary * userinfo = dict[@"userinfo"];
        [model setValuesForKeysWithDictionary:userinfo];
        
        [result addObject:model];
    }
    
    return result;
}

@end
