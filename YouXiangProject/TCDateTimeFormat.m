//
//  TCDateTimeFormat.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "TCDateTimeFormat.h"

@implementation TCDateTimeFormat


+ (NSString *)datetimeFromLong:(long long)dtSince1970
{
    NSDate * date = [NSDate dateWithTimeIntervalSince1970:dtSince1970 ];
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents * dateComponents = [calendar components:NSSecondCalendarUnit|NSMinuteCalendarUnit|NSHourCalendarUnit| NSDayCalendarUnit|NSWeekdayCalendarUnit| NSMonthCalendarUnit| NSYearCalendarUnit fromDate:date toDate:[NSDate date] options:0];
    
    NSString * result = nil;
    
    if (dateComponents.year) {
         NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        result = [dateFormatter stringFromDate:date];
    }else if(dateComponents.month){
        result = [NSString stringWithFormat:@"%ld个月前", dateComponents.month];
    }else if(dateComponents.weekday){
        result = [NSString stringWithFormat:@"%ld周前", dateComponents.weekday];
    }else if(dateComponents.day){
        result = [NSString stringWithFormat:@"%ld天前", dateComponents.day];
    }else if (dateComponents.hour){
        result = [NSString stringWithFormat:@"%ld小时前", dateComponents.hour];
    }else if(dateComponents.minute){
        result = [NSString stringWithFormat:@"%ld分钟前", dateComponents.minute];
    }else if(dateComponents.second){
        result = [NSString stringWithFormat:@"%ld秒前", dateComponents.second];
    }
    
    return result;
}




@end
