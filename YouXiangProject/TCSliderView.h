//
//  TCSliderView.h
//  TCSliderView
//
//  Created by qianfeng on 15/1/23.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  TCSliderView;

@protocol TCSliderViewDelegate  <NSObject>

- (void)sliderView:(TCSliderView *)sliderView didPresentedWithIndex:(NSInteger)index;

@end


@interface TCSliderView : UIView

@property (nonatomic, strong) NSArray * urlStringArray;
@property (nonatomic, strong) NSArray * imageNameArray;
@property (nonatomic, assign) BOOL isSlid;
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, weak)id<TCSliderViewDelegate> delegate;
@property (nonatomic, strong) UIPageControl * pageControl;

@end
