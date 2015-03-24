//
//  YXCheckBoxView.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/30.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXCheckBoxView.h"

@implementation YXCheckBoxView
{
    UIButton * _checkButton;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)setIsChecked:(BOOL)isChecked
{
    _isChecked =  isChecked;
    if (isChecked) {
        [_checkButton setBackgroundImage:[UIImage imageNamed:@"flight_butn_check_select"] forState:UIControlStateNormal];
    }else {
    [_checkButton setBackgroundImage:[UIImage imageNamed:@"flight_butn_check_unselect"] forState:UIControlStateNormal];
    }
    
    if ([self.delegate respondsToSelector:@selector(checkBox:isChecked:)]) {
        [self.delegate checkBox:self isChecked:_isChecked];
    }
    
    
}

- (void)awakeFromNib
{
    _isChecked = NO;
    _checkButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _checkButton.frame = self.bounds;
    [_checkButton setBackgroundImage:[UIImage imageNamed:@"flight_butn_check_unselect"] forState:UIControlStateNormal];
    [_checkButton addTarget:self action:@selector(btnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_checkButton];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)btnClicked
{
    if (_isChecked) {
        [self setIsChecked:NO];
    }else {
        [self setIsChecked:YES];
    }
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
