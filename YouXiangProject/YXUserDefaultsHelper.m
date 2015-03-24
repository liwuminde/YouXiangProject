//
//  YXUserDefaultsHelper.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXUserDefaultsHelper.h"
#import "YXReginModel.h"
@implementation YXUserDefaultsHelper


+ (void)saveDefaultAddress:(NSArray *)array
{
    if (array.count < 3) {
        NSLog(@"地点数据不正确");
        return;
    }
    
    YXReginModel * province = array[0];
    YXReginModel * city = array[1];
    YXReginModel * regins = array[2];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSDictionary * provinceDict = @{@"region_id": province.region_id,
                                    @"region_name": province.region_name};
    
    NSDictionary * cityDict =  @{@"region_id": city.region_id,
                                 @"region_name": city.region_name};
    
    NSDictionary * reginDict =  @{@"region_id": regins.region_id,
                                  @"region_name": regins.region_name};
    
    NSDictionary * defaultAddress = @{@"province": provinceDict,
                                      @"city":cityDict,
                                      @"regin":reginDict};
    
    [defaults setObject:defaultAddress forKey:@"defaultAddress"];
    [defaults synchronize];
}

+ (NSArray *)getDefaultAddress
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults synchronize];
    NSDictionary * defaultAddress  = [defaults objectForKey:@"defaultAddress"];
    
    if (!defaultAddress) {
        return nil;
    }
    
    YXReginModel * province = [YXReginModel getModelWithDict:defaultAddress[@"province"]];
    YXReginModel * city = [YXReginModel getModelWithDict:defaultAddress[@"city"]];
    YXReginModel * regins = [YXReginModel getModelWithDict:defaultAddress[@"regin"]];
    
    NSLog(@"%@ %@ %@", province.region_name, city.region_name, regins.region_name);
    
    return @[province, city, regins];
}

+ (void)saveSessionKey:(NSString *)sessionkey userId:(NSString *)userId
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setValue:sessionkey forKey:@"sessionid"];
    [defaults setValue:userId forKey:@"user_id"];
    [defaults synchronize];
}

+ (NSString *)getSessionkey
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:@"sessionid"];
}





@end
