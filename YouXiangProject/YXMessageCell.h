//
//  YXMessageCell.h
//  YouXiangProject
//
//  Created by qianfeng on 15/2/3.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXMessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellPhotoImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cellBackgroundImageView;
@property (weak, nonatomic) IBOutlet UIImageView *cellImageContentImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellTextContentLabel;

@property (nonatomic, assign) BOOL isSend;

@end
