//
//  YXPageViewController.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/29.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXBaseViewController.h"

@interface YXPageViewController : YXBaseViewController

- (void)setPageContents:(NSArray *)array;
- (void)setCurrentPage:(NSInteger) index;
- (void)setMenuBarItemTitles:(NSArray *)array;
@end
