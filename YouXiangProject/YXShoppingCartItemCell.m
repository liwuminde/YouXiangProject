//
//  YXShoppingCartItemCell.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/30.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXShoppingCartItemCell.h"

@implementation YXShoppingCartItemCell

- (void)awakeFromNib
{
    // Initialization code
    
    [_itemImageView.layer setCornerRadius:10.0];
    _itemImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
