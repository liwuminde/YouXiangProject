//
//  YXCommentCell.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/28.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXCommentCell.h"

@implementation YXCommentCell

- (void)awakeFromNib
{
    // Initialization code
    [self.commentImageView.layer setCornerRadius:self.commentImageView.frame.size.width / 2];
    self.commentImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setCommentDetail:(NSString *)comment
{
    
    NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
   
    CGSize size = [comment boundingRectWithSize:CGSizeMake(230, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    self.commentDetailLabel.frame = CGRectMake(66, 23, 230, size.height);
    self.commentDetailLabel.text = comment;
    CGFloat height = CGRectGetMaxY(self.commentDetailLabel.frame);
    
    if (height > 65) {
        self.bounds = CGRectMake(0, 0, self.frame.size.width, height + 10);
    }
    
}


@end
