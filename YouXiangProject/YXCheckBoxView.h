//
//  YXCheckBoxView.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/30.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXCheckBoxView;
@protocol YXCheckBoxViewDelegate <NSObject>
- (void)checkBox:(YXCheckBoxView *)checkBox isChecked:(BOOL)isChecked;
@end


@interface YXCheckBoxView : UIView

@property (nonatomic, assign) BOOL isChecked;
@property (nonatomic, weak) id <YXCheckBoxViewDelegate> delegate;

@end


