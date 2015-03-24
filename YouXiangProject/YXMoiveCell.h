//
//  YXMoiveCell.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/27.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YXMoiveCellDelegate <NSObject>

- (void)cellClicked:(NSIndexPath *)indexPath;
- (void)sharedButtonClicked:(NSIndexPath *)indexPath;
- (void)upButtonClicked:(NSIndexPath *)indexPath State:(BOOL)state;
- (void)commentClicked:(NSIndexPath *)indexPath;

@end

@interface YXMoiveCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView * moiveImageView;

@property (weak, nonatomic) IBOutlet UILabel * moiveTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel * moiveBackgroundLabel;
@property (weak, nonatomic) IBOutlet UIView * moiveMainView;
@property (strong, nonatomic) NSIndexPath * indexPath;
@property (weak, nonatomic) id<YXMoiveCellDelegate> delegate;
@property (assign, nonatomic)  BOOL upButtonState;

@property (assign, nonatomic) NSInteger upCount;

- (IBAction)moiveShareButtonClicked:(id)sender;
- (IBAction)moiveUpClicked:(UIButton *)sender;
- (IBAction)moiveCommentClicked:(UIButton *)sender;

@end
