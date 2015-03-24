//
//  YXSteperView.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/30.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXSteperView.h"

@implementation YXSteperView
{
    UILabel * _label;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIButton * left = [UIButton buttonWithType:UIButtonTypeCustom];
        [left setBackgroundImage:[UIImage imageNamed:@"产品详情_19.png"] forState:UIControlStateNormal];
        left.frame = CGRectMake(0,0.5, 17, 17);
        [left addTarget:self action:@selector(leftBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:left];
        
        _label = [[UILabel alloc] initWithFrame:CGRectMake(21, 0, 26, 18)];
        
        [self addSubview:_label];
        _label.text = @"0";
        _label.font = [UIFont systemFontOfSize:13];
        _label.textAlignment = NSTextAlignmentCenter;
        [_label.layer setBorderWidth:1.0]; //边框宽度
        CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
        CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.5 });
        [_label.layer setBorderColor:colorref];//边框颜色
        

        UIButton * right = [UIButton buttonWithType:UIButtonTypeCustom];
        [right setBackgroundImage:[UIImage imageNamed:@"产品详情_23.png"] forState:UIControlStateNormal];
        right.frame = CGRectMake(50, 0.5, 17,17);
        [self addSubview:right];
        [right addTarget:self action:@selector(rightBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        
        
    }
    return self;
}

- (void)leftBtnClicked
{
    if (_stepValue > 0) {
        _stepValue--;
    }
    
    _label.text = [NSString stringWithFormat:@"%ld", _stepValue];
}

- (void)rightBtnClicked
{
    if (_stepValue < 99) {
        _stepValue++;
    }
    _label.text = [NSString stringWithFormat:@"%ld", _stepValue];
}


- (void)setStepValue:(NSInteger)stepValue
{
    if (stepValue >= 0 && stepValue <= 99) {
        _stepValue = stepValue;
        _label.text = [NSString stringWithFormat:@"%ld", _stepValue];
    }
}
- (void)awakeFromNib
{
    [self initWithFrame:self.frame];
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
