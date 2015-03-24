//
//  YXBaseObject.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/27.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXBaseObject.h"

@implementation YXBaseObject

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}

+ (NSArray *)getModelsFromArray:(NSArray *)array
{
    NSMutableArray * result = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        Class cls = [self class];
        id model =  [[cls alloc] init];

        [model setValuesForKeysWithDictionary:dict];
        
        for (NSString * key in dict) {
            id obj = dict[key];
            if ([obj isKindOfClass:[NSNumber class]]) {
                [model setValue:[obj stringValue] forKey:key];
                
            }
        }
        
        [result addObject:model];
    }
    
    return result;
}

+ (NSArray *)getModelsFromDict:(NSDictionary *)dict
{
    NSMutableArray * result = [NSMutableArray array];
    
    for (NSString * key in dict) {
        NSDictionary * values = dict[key];
        
        Class cls = [self class];
        id model =  [[cls alloc] init];
        
        [model setValuesForKeysWithDictionary:values];
        
        for (NSString * key in values) {
            id obj = values[key];
            if ([obj isKindOfClass:[NSNumber class]]) {
                [model setValue:[obj stringValue] forKey:key];
            }
        }
        
        [result addObject:model];
    }
    
    return result;
}

+ (id)getModelWithDict:(NSDictionary *)dict
{
    Class cls = [self class];
    id model =  [[cls alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    
    for (NSString * key in dict) {
        id obj = dict[key];
        if ([obj isKindOfClass:[NSNumber class]]) {
            [model setValue:[obj stringValue] forKey:key];
        }
    }
    
    return model;
}


@end
