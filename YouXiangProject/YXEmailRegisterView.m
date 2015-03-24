//
//  YXEmailRegisterView.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXEmailRegisterView.h"

@implementation YXEmailRegisterView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.usernameField resignFirstResponder];
    [self.passwordField resignFirstResponder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
