//
//  YXUserDefaultsHelper.h
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXUserDefaultsHelper : NSObject

+ (void)saveDefaultAddress:(NSArray *)array;
+ (NSArray *)getDefaultAddress;

+ (void)saveSessionKey:(NSString *)sessionkey userId:(NSString *)userId;
+ (NSString *)getSessionkey;

@end
