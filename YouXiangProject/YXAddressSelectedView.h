//
//  YXAddressSelectedView.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXReginModel.h"
@interface YXAddressSelectedView : UIView

@property (nonatomic, strong) YXReginModel * country;
@property (nonatomic, strong) YXReginModel * province;
@property (nonatomic, strong) YXReginModel * city;
@property (nonatomic, strong) YXReginModel * regins;
@property (nonatomic, weak) id alertWindow;

- (void) addTaget:(id)target action:(SEL)action;

@end
