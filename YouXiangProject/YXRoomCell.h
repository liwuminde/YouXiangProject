//
//  YXRoomCell.h
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXRoomCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *cellPhotoImageView;
@property (weak, nonatomic) IBOutlet UILabel *cellTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellDtaeLabel;

@property (weak, nonatomic) IBOutlet UILabel *cellLoveLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellUsersNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *cellLastCommenTimeLabel;

@property (weak, nonatomic) IBOutlet UIView *cellTopBarView;
@property (weak, nonatomic) IBOutlet UILabel *cellDetailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *cellContentImageView;

@end
