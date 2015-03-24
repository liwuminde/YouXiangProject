//
//  YXReginCell.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXCheckBoxView.h"
@interface YXReginCell : UITableViewCell
@property (weak, nonatomic) IBOutlet YXCheckBoxView *reginCheckbox;
@property (weak, nonatomic) IBOutlet UILabel *reginNameLabel;

@end
