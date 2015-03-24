//
//  YXOrderGoodsCell.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YXSteperView.h"
@interface YXOrderGoodsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *orderGoodsImageView;
@property (weak, nonatomic) IBOutlet UILabel *orderGoodsTitelLabel;

@property (weak, nonatomic) IBOutlet YXSteperView *orderSteperView;
@property (weak, nonatomic) IBOutlet UILabel *orderGoodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *orderGoodsPostPriceLabel;

@end
