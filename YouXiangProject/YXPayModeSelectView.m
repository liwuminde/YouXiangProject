//
//  YXPayModeSelectView.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXPayModeSelectView.h"
#import "UIView+Border.h"
#import "TCAlertWindow.h"
@implementation YXPayModeSelectView
{
    
    __weak IBOutlet UIButton *_cancelButton;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    for (NSInteger i = 0; i < 4; i++) {
        UIButton * btn = (UIButton *)[self viewWithTag:100 + i];
        
        if (btn) {
            [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    [_cancelButton setBorderRadius:5];
    
    [_cancelButton addTarget:self action:@selector(cancelBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClicked:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(selectedPayModel:tag:)]) {
        [self.delegate selectedPayModel:btn.currentTitle tag:btn.tag - 100];
    }
    
    if (_alertWindow) {
        TCAlertWindow * alert = (TCAlertWindow *)_alertWindow;
        [alert closeWindow];
    }
}

- (void)cancelBtnClicked:(UIButton *)btn
{
    if (_alertWindow) {
        TCAlertWindow * alert = (TCAlertWindow *)_alertWindow;
        [alert closeWindow];
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
