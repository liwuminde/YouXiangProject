//
//  YXBasicReusableView.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/29.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXBasicReusableView.h"

@implementation YXBasicReusableView
{
    UILabel * _label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _label =[[UILabel alloc] initWithFrame:CGRectMake(10, 0, frame.size.width - 10, frame.size.height)];
        _label.font = [UIFont systemFontOfSize:13];
        _label.textColor = [UIColor blackColor];
        
        [self addSubview:_label];
    }
    return self;
}


- (void)setLabelTitle:(NSString *)title
{
    _label.text =  title;
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
