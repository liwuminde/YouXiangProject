//
//  YXScenePage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXScenePage.h"
#import "UIImageView+WebCache.h"
#import "YXRoomModel.h"
#import "YXRoomCell.h"
#import "UIView+Border.h"
#import "TCDateTimeFormat.h"
#import "YXRoomApplyPage.h"
#import "YXRoomPage.h"
@interface YXScenePage ()

@end

@implementation YXScenePage

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
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavgationTitle:@"现场"];
    
    UIButton * itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemBtn setBackgroundImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    itemBtn.frame = CGRectMake(0, 0,16, 16);
    [itemBtn addTarget:self action:@selector(addItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * addItem = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    NSArray * itemArray = @[addItem];
    
    self.navigationItem.rightBarButtonItems = itemArray;
    
    [self refreshData];
    
}

- (void)addItemClicked:(UIButton *)btn
{
    YXRoomApplyPage * apply = [[YXRoomApplyPage alloc] init];
    [self.navigationController pushViewController:apply animated:YES];
}

- (void)refreshData
{
    YXHttpRequest * request = [[YXHttpRequest alloc] init];
    NSString * path = [NSString stringWithFormat:kRoomList, (long)1, _countOfAPage];
    [request afGetWithUrlString:path finished:^(id responseObj) {
        NSArray * dataArray  = responseObj[@"msg"][@"data"];
        _currentPage =  1;
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:[YXRoomModel getModelsFromArray:dataArray]];
        
        _totalPage = [responseObj[@"msg"][@"page"][@"allpage"] integerValue];
        
        [_tableView reloadData];
        [_refreshControl endRefreshing];
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (void)loadData
{
    YXHttpRequest * request = [[YXHttpRequest alloc] init];
    NSString * path = [NSString stringWithFormat:kRoomList, ++_currentPage, _countOfAPage];
    [request afGetWithUrlString:path finished:^(id responseObj) {
        NSArray * dataArray  = responseObj[@"msg"][@"data"];
        [_dataArray addObjectsFromArray:[YXRoomModel getModelsFromArray:dataArray]];
        
        [_tableView reloadData];
        [_refreshControl endRefreshing];
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 316.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXRoomCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YXRoomCell"];

    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YXRoomCell" owner:self options:nil] lastObject];
    }
    
    YXRoomModel * model = _dataArray[indexPath.row];
    
    [cell.cellPhotoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@", model.face]]];
    
    cell.cellTitleLabel.text = model.username;
    [cell.cellContentImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@", model.pic]] placeholderImage:[UIImage imageNamed:@"现场_11.png"]];
    
    NSLog(@"%@", model.face);
    NSArray * colorArray = @[[UIColor colorWithRed:1 green:0.64 blue:0.22 alpha:1],
                             [UIColor colorWithRed:0 green:0.58 blue:0.81 alpha:1],
                             [UIColor colorWithRed:0.48 green:0.73 blue:0.24 alpha:1],
                             [UIColor colorWithRed:0.64 green:0.56 blue:0.46 alpha:1],
                             [UIColor colorWithRed:0.89 green:0.24 blue:0.36 alpha:1],
                             [UIColor colorWithRed:0.5 green:0.43 blue:0.61 alpha:1]];
    
    cell.cellTopBarView.backgroundColor = colorArray[indexPath.row % colorArray.count];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.cellDetailLabel.text = model.name;
    cell.cellDtaeLabel.text = [TCDateTimeFormat datetimeFromLong:[model.addtime integerValue]];
    cell.cellLastCommenTimeLabel.text = [TCDateTimeFormat datetimeFromLong:[model.updatetime integerValue]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YXRoomModel * model = _dataArray[indexPath.row];
    
    YXRoomPage * page = [[YXRoomPage alloc] init];
    page.roomModel = model;
    [self.navigationController pushViewController:page animated:YES];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
