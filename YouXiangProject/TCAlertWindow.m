//
//  TCAlertWindow.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "TCAlertWindow.h"

@implementation TCAlertWindow
{
    CGRect _rootViewBounds;
    CGPoint _rootViewCenter;
    UILabel * titleLabel;
    UIView * _customView;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createDefaultRootView];
        [self configUI];
    }
    return self;
}

- (void)createDefaultRootView
{
    _rootView = [[UIView alloc]initWithFrame:CGRectMake(30, 100, 260, 200)];
    _rootView.backgroundColor = [UIColor whiteColor];
    
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 12, 260, 20)];
    titleLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.font = [UIFont systemFontOfSize:18];
    titleLabel.textColor = [UIColor colorWithRed:1 green:0.41 blue:0.41 alpha:1];
    titleLabel.text = @"请选择地区";
    [_rootView addSubview:titleLabel];
    
    UIButton * closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_picker_close_select_h"] forState:UIControlStateSelected];
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_picker_close"] forState:UIControlStateNormal];
    closeBtn.frame = CGRectMake(227, 8, 25, 25);
    [closeBtn addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
    closeBtn.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
   
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, titleLabel.frame.size.width, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    [_rootView addSubview:lineLabel];
    
  
    [_rootView addSubview:closeBtn];
}

- (void)closeBtn
{
    [self tapClicked];
}

- (id)initWithCustomView:(UIView *)customView
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        
        if (customView != nil) {
            _customView = customView;
            [self createDefaultRootView];
            [self configCustomView];
            [self configUI];
        }
    }
    return self;
}

- (void)configCustomView
{
    CGRect bounds = _customView.bounds;
    CGRect frame = [[UIScreen mainScreen] bounds];
    _customView.frame = CGRectMake(0, 41, bounds.size.width, bounds.size.height);
    [_rootView addSubview:_customView];
   // _customView.hidden = YES;
    _rootView.frame = CGRectMake(0, 0, bounds.size.width, bounds.size.height + 40);
    _rootView.center = CGPointMake(frame.size.width / 2.f, frame.size.height / 2.f);
}

- (void)configUI
{
    [[[UIApplication sharedApplication].delegate window].rootViewController.view addSubview:self];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.frame = frame;
    
    UIButton * maskButton = [UIButton buttonWithType:UIButtonTypeCustom];
    maskButton.frame = frame;
    [maskButton addTarget:self action:@selector(closeBtn) forControlEvents:UIControlEventTouchUpInside];
   // [self addSubview:maskButton];
    
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self addSubview:_rootView];
    _rootView.center = CGPointMake(frame.size.width / 2.f, frame.size.height / 2.f);
    [_rootView.layer setCornerRadius:7.0];
    _rootView.layer.masksToBounds = YES;
    
    [self rootViewAnimate];
}

- (void)tapClicked
{
    [UIView animateWithDuration:0.25 animations:^{
        _rootView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 动画效果
- (void)rootViewAnimate
{
    _rootViewBounds = _rootView.bounds;
    _rootViewCenter = _rootView.center;
    _rootView.bounds = CGRectZero;
    _rootView.center = _rootViewCenter;
    
    CGRect bounds = CGRectZero;
    bounds.size.height =  _rootViewBounds.size.height + 20;
    bounds.size.width = _rootViewBounds.size.width + 20;

    [UIView animateWithDuration:0.15 animations:^{
        
        _rootView.center = _rootViewCenter;
        _rootView.bounds = bounds;
        
    } completion:^(BOOL finished) {
        [self rootViewAnimateToSmall];
    }];
}

- (void)rootViewAnimateToSmall
{
    CGRect bounds = CGRectZero;
    bounds.size.height =  _rootViewBounds.size.height - 20;
    bounds.size.width = _rootViewBounds.size.width - 20;
    
    [UIView animateWithDuration:0.15 animations:^{
        _rootView.center = _rootViewCenter;
        _rootView.bounds = bounds;
    } completion:^(BOOL finished) {
        [self rootViewAnimateToBig];
    }];
}

- (void)rootViewAnimateToBig
{
    [UIView animateWithDuration:0.1 animations:^{
        
        _rootView.center = _rootViewCenter;
        _rootView.bounds = _rootViewBounds;
        
    } completion:^(BOOL finished) {
        if (_customView) {
            _customView.hidden = NO;
        }
    }];
}

- (void)doNothing
{
    
}
#pragma mark - 对外接口
- (void)setTitle:(NSString *)title
{
    titleLabel.text = title;
}

- (void)closeWindow
{
    [self tapClicked];
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
