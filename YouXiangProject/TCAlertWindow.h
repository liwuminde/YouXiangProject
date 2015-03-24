//
//  TCAlertWindow.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TCAlertWindow : UIView

@property (nonatomic, strong) UIView * rootView;

- (void)setTitle:(NSString *)title;
- (id)initWithCustomView:(UIView *)customView;

- (void)closeWindow;
@end
