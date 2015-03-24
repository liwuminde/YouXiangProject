//
//  YXMessageCell.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/3.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXMessageCell.h"
#import "UIView+Border.h"
@implementation YXMessageCell


- (void)awakeFromNib {
    // Initialization code
    [self.cellPhotoImageView setBorderRadius:self.cellPhotoImageView.frame.size.width / 2];
    
}
//chatBubble_Sending_Solid
//chatBubble_Receiving_Solid

- (void)setIsSend:(BOOL)isSend
{
    _isSend = isSend;
    
    if (isSend) {
        [self senderLayout];
    }else {
        [self receiverLayout];
    }
}


- (void)senderLayout
{
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    _cellPhotoImageView.frame = CGRectMake(frame.size.width - 10 - 32, 10, 32, 32);
    _cellImageContentImageView.hidden = YES;
    [_cellBackgroundImageView setImage:[[UIImage imageNamed:@"chatBubble_Sending_Solid.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(24, 9, 10.5, 15) resizingMode:UIImageResizingModeTile]];
    
    CGSize size = [self currentSize];

}

- (void)receiverLayout
{
    
}


- (CGSize)currentSize
{
    CGSize size;
    //获取系统版本号
    CGFloat version = [[UIDevice currentDevice].systemVersion floatValue];
    if (version >= 7.0) {
        NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
        size = [_cellTextContentLabel.text boundingRectWithSize:CGSizeMake(200, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    }else {
      
        size = [_cellTextContentLabel.text sizeWithFont:[UIFont systemFontOfSize:12] constrainedToSize:CGSizeMake(200, 999) lineBreakMode:NSLineBreakByCharWrapping];
    }
    
    return size;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
