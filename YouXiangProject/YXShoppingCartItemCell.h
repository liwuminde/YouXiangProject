//
//  YXShoppingCartItemCell.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/30.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#include "YXCheckBoxView.h"
#include "YXSteperView.h"
@interface YXShoppingCartItemCell : UITableViewCell

@property (weak, nonatomic) IBOutlet YXCheckBoxView *itemCheckBox;

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView;
@property (weak, nonatomic) IBOutlet YXSteperView *itemSteperView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *itemTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *itemDelete;



@end
