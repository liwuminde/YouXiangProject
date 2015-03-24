//
//  YXListViewController.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/28.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXBaseViewController.h"
#import "ODRefreshControl.h"
#import "YXHttpRequest.h"

@interface YXListViewController : YXBaseViewController <UITableViewDataSource, UITableViewDelegate>
{
    UITableView     * _tableView;
    NSMutableArray  * _dataArray;
    ODRefreshControl* _refreshControl;
    UIView          * _loadControl;
    
    YXHttpRequest   * _request;
    
    NSInteger         _currentPage;
    NSInteger         _totalPage;
    NSInteger         _countOfAPage;
    NSInteger         _countOfAll;
}


- (void)setloadControlTitle:(NSString *)title;


@end
