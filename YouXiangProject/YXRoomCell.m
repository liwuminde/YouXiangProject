//
//  YXRoomCell.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXRoomCell.h"
#import "UIView+Border.h"
@implementation YXRoomCell

- (void)awakeFromNib
{
    // Initialization code
    
    [_cellPhotoImageView setBorderRadius:_cellPhotoImageView.frame.size.width / 2];
    [_cellPhotoImageView setBorderColor:[UIColor whiteColor] width:2];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
