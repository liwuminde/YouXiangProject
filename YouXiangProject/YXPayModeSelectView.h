//
//  YXPayModeSelectView.h
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YXPayModeSelectView;

@protocol YXPayModeSelectViewDelegate <NSObject>

- (void)selectedPayModel:(NSString *)payModeName tag:(NSInteger)tag;

@end


@interface YXPayModeSelectView : UIView

@property (nonatomic, weak) id<YXPayModeSelectViewDelegate> delegate;
@property (nonatomic, weak) id alertWindow;

@end
