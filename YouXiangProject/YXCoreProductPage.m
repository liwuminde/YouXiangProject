//
//  YXCoreProductPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/29.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXCoreProductPage.h"
#import "UIImageView+WebCache.h"
#import "YXProductModel.h"
#import "YXCoreProductCell.h"
#import "YXCoreProductDetailPage.h"
@interface YXCoreProductPage ()

@end

@implementation YXCoreProductPage

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
    CGRect frame = [[UIScreen mainScreen] bounds];
    _tableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 64 - 35);
    _tableView.tableFooterView = nil;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self refreshData];
}

- (void)refreshData
{
    if (!_request) {
        _request = [[YXHttpRequest alloc] init];
    }
    
    [_request afGetWithUrlString:core_product finished:^(id responseObj) {
        [_dataArray removeAllObjects];
        NSDictionary * dataDict = responseObj[@"msg"][@"data"];
        [_dataArray addObjectsFromArray:[YXProductModel getModelsFromDict:dataDict]];
        
        [_tableView reloadData];
        _currentPage = 1;
        _totalPage = 1;
        [_refreshControl endRefreshing];
        NSLog(@"%@", responseObj);
    } failed:^(NSString *errorMsg) {
    
    }];
}

- (void)loadData
{
    [self refreshData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXCoreProductCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YXCoreProductCell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YXCoreProductCell" owner:self options:nil]lastObject];
    }
    
    YXProductModel * model = _dataArray[indexPath.row];
    [cell.coreProductImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@",model.goods_thumb]]];
    
    if (indexPath.row < 9) {
        cell.coreProductIndexLabel.text = [NSString stringWithFormat:@"0%ld", indexPath.row + 1];
    }else {
        cell.coreProductIndexLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    }
    
    cell.coreProductTitleLabel.text = model.name;

    NSArray * colorArray = @[[UIColor colorWithRed:1 green:0.64 blue:0.22 alpha:1],
                             [UIColor colorWithRed:0 green:0.58 blue:0.81 alpha:1],
                             [UIColor colorWithRed:0.48 green:0.73 blue:0.24 alpha:1],
                             [UIColor colorWithRed:0.64 green:0.56 blue:0.46 alpha:1],
                             [UIColor colorWithRed:0.89 green:0.24 blue:0.36 alpha:1],
                             [UIColor colorWithRed:0.5 green:0.43 blue:0.61 alpha:1]];
    
    cell.backgroundColor = colorArray[indexPath.row % colorArray.count];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXCoreProductCell * cell =(YXCoreProductCell *) [tableView cellForRowAtIndexPath:indexPath];
    YXCoreProductDetailPage * detail  =[[YXCoreProductDetailPage alloc] init];
    YXProductModel * model = _dataArray[indexPath.row];
    detail.productId = model.goods_id;
    detail.bkColor = cell.backgroundColor;
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.f;
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
