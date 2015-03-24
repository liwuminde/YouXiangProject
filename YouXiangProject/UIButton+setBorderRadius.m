//
//  UIButton+setBorderRadius.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "UIButton+setBorderRadius.h"

@implementation UIButton (setBorderRadius)

- (void)setBorderRadius:(CGFloat)radius
{
    [self.layer setCornerRadius:5.0];
    self.layer.masksToBounds = YES;
}

@end
