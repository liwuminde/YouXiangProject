//
//  YXScrollView.h
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXScrollViewDelegate <NSObject,UIScrollViewDelegate>

- (void)YXScrollViewTouchBegin;

@end

@interface YXScrollView : UIScrollView

@property (nonatomic, assign) id <YXScrollViewDelegate> delegate ;

@end
