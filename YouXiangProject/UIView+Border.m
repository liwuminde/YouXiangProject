//
//  UIView+Border.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "UIView+Border.h"

@implementation UIView (Border)

- (void)setBorderRadius:(CGFloat)radius
{
    [self.layer setCornerRadius:radius];
    self.layer.masksToBounds = YES;
}

- (void)setBorderColor:(UIColor *)color width:(CGFloat)width
{
    [self.layer setBorderWidth:width]; //边框宽度
    //CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    //CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.1 });
    CGColorRef colorref = [color CGColor];
    [self.layer setBorderColor:colorref];//边框颜色
}






@end
