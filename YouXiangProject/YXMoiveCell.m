//
//  YXMoiveCell.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/27.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXMoiveCell.h"

@implementation YXMoiveCell
{
    __weak IBOutlet UIImageView * iconImageView;
    __weak IBOutlet UIButton * upButton;
  
}
- (void)awakeFromNib
{
    [_moiveMainView.layer setCornerRadius:5.0];
    _moiveMainView.layer.masksToBounds = YES;
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    iconImageView.userInteractionEnabled = YES;
    [iconImageView addGestureRecognizer:tap];
    _upButtonState = YES;
}

- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    if ([self.delegate respondsToSelector:@selector(cellClicked:)]) {
        [self.delegate cellClicked:self.indexPath];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)moiveShareButtonClicked:(id)sender {
    if ([self.delegate respondsToSelector:@selector(sharedButtonClicked:)]) {
        [self.delegate sharedButtonClicked:self.indexPath];
    }
}

- (IBAction)moiveUpClicked:(UIButton *)sender {

    if ([self.delegate respondsToSelector:@selector(upButtonClicked:State:)]) {
        [self.delegate upButtonClicked:self.indexPath State:self.upButtonState];
    }
}

- (IBAction)moiveCommentClicked:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(commentClicked:)]) {
        [self.delegate commentClicked:self.indexPath];
    }
}


- (void)setUpButtonState:(BOOL)upButtonState
{
    _upButtonState = upButtonState;
    
    if (_upButtonState) {
        [upButton setTitle:@"赞" forState:UIControlStateNormal];
        [upButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [upButton setTitle:@"已赞" forState:UIControlStateNormal];
        [upButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];

    }
}

- (void)setUpCount:(NSInteger)upCount
{
    if (_upButtonState) {
        [upButton setTitle:[NSString stringWithFormat:@"赞 (%ld)", upCount] forState:UIControlStateNormal];
        [upButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }else{
        [upButton setTitle:[NSString stringWithFormat:@"已赞 (%ld)", upCount] forState:UIControlStateNormal];
        [upButton setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    }
}




@end
