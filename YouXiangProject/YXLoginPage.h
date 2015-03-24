//
//  YXLoginPage.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXBaseViewController.h"
@interface YXLoginPage : YXBaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *loginImageView;
@property (weak, nonatomic) IBOutlet UITextField *loginUserNameField;

@property (weak, nonatomic) IBOutlet UITextField *loginPassWordField;


@end
