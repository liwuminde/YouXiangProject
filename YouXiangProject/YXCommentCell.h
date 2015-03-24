//
//  YXCommentCell.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/28.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YXCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *commentImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentTitleLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentReplayButton;
@property (weak, nonatomic) IBOutlet UILabel *commentDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentFloorLabel;

- (void)setCommentDetail:(NSString *)comment;

@end
