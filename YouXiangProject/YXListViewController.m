//
//  YXListViewController.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/28.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXListViewController.h"

@interface YXListViewController ()
{
    UIButton * _loadControlButton;
    BOOL isCanLoad;
}
@end

@implementation YXListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    
    _currentPage = 0;
    _totalPage = 0;
    _countOfAPage = 10;
    _countOfAll = 0;
    
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width , frame.size.height - 64) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    [self.view addSubview:_tableView];
    
    _refreshControl = [[ODRefreshControl alloc] initInScrollView:_tableView];
    [_refreshControl addTarget:self action:@selector(dropViewDidBeginRefreshing:) forControlEvents:UIControlEventValueChanged];
    
    _loadControl = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
    _loadControlButton = [[UIButton alloc] initWithFrame:CGRectMake(5, 10, frame.size.width - 10, 30)];
    [_loadControlButton setTitle:@"点击加载更多数据" forState:UIControlStateNormal];
    _loadControlButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_loadControlButton addTarget:self action:@selector(upPullControlClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_loadControlButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_loadControl addSubview:_loadControlButton];
    _tableView.tableFooterView = _loadControl;
    
    [_loadControlButton.layer setCornerRadius:5.0]; //设置矩形四个圆角半径
    [_loadControlButton.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.1 });
    [_loadControlButton.layer setBorderColor:colorref];//边框颜色
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"请重写基类方法:%s",__FUNCTION__);
    return 0;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"请重写基类方法:%s",__FUNCTION__);
    return nil;
}

- (void)dropViewDidBeginRefreshing:(ODRefreshControl *)refreshControl
{
    [self refreshData];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_tableView.contentOffset.y + _tableView.frame.size.height >= _tableView.contentSize.height) {
        isCanLoad = YES;
    }
}


- (void)upPullControlClicked:(UIButton *)btn
{
    [self loadData];
}

- (void)setloadControlTitle:(NSString *)title
{
    [_loadControlButton setTitle:title forState:UIControlStateNormal];
}

- (void)refreshData
{
    NSLog(@"刷新数据...");
}

- (void)loadData
{
    NSLog(@"加载数据...");
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
