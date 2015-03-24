//
//  YXShoppingCartPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/30.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXShoppingCartPage.h"
#import "YXCheckBoxView.h"
#import "YXShoppingCartItemCell.h"
#import "YXHttpRequest.h"
#import "YXCartGoodsModel.h"
#import "UIImageView+WebCache.h"
#import "YXCartInfoView.h"
#import "YXOrderFormInfoPage.h"
@interface YXShoppingCartPage () <UITableViewDataSource, UITableViewDelegate, YXCheckBoxViewDelegate>
{
    __weak IBOutlet UIView *_bottomBarView;
    __weak IBOutlet YXCheckBoxView *_allCheckBox;
    __weak IBOutlet UILabel *_totalPriceLabel;
    __weak IBOutlet UIButton *_cashButton;
    
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    
    YXCartInfoView * _cartInfoView;
  
}
@end

@implementation YXShoppingCartPage

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
    // Do any additional setup after loading the view from its nib.
    _dataArray = [NSMutableArray array];
    [self setNavgationTitle:@"购物车"];
    self.navigationController.navigationBar.translucent = NO;
    CGRect frame = [[UIScreen mainScreen] bounds];
    _bottomBarView.center = CGPointMake(_bottomBarView.center.x, (frame.size.height- 64 - _bottomBarView.frame.size.height/2));
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 65 - _bottomBarView.frame.size.height) style:UITableViewStylePlain];
   // _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _allCheckBox.isChecked = YES;
    _allCheckBox.tag =  1000;
    _allCheckBox.delegate = self;
    _tableView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];


    _cartInfoView = [[[NSBundle mainBundle]loadNibNamed:@"YXCartInfoView" owner:self options:nil] lastObject];
    
    _tableView.tableFooterView = _cartInfoView;
    
    [_cashButton addTarget:self action:@selector(buyClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self refreshData];
}

- (void)buyClicked
{
    YXOrderFormInfoPage * order = [[YXOrderFormInfoPage alloc] init];
    
    [self.navigationController pushViewController:order animated:YES];
}

- (void)refreshData
{
    YXHttpRequest * request = [[YXHttpRequest alloc] init];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sesskey = [defaults objectForKey:@"cartsesskey"];
    NSString * path = [NSString stringWithFormat:getcart ,sesskey];
    
    [request afGetWithUrlString:path finished:^(id responseObj) {
        NSInteger code = [responseObj[@"code"] integerValue];
        
        if (code == 1) {
            NSArray * dataArray = responseObj[@"msg"][@"data"][@"goods_list"];
            
            [_dataArray addObjectsFromArray:[YXCartGoodsModel getModelsFromArray:dataArray]];
            
            NSString * price = [responseObj[@"msg"][@"data"][@"total"][@"goods_amount"] stringValue];
            
            _totalPriceLabel.text = [NSString stringWithFormat:@"合计：￥%@", price];
            
            NSString * num =  [responseObj[@"msg"][@"data"][@"total"][@"real_goods_count"] stringValue];
            _cartInfoView.totalNumLabel.text = [NSString stringWithFormat:@"共计%@件商品", num];
            _cartInfoView.totalPriceLabel.text = [NSString stringWithFormat:@"合计 %@元", price];
            
            [_tableView reloadData];
            
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXShoppingCartItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YXShoppingCartItemCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YXShoppingCartItemCell" owner:self options:nil] lastObject];
    }
    YXCartGoodsModel * model = _dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.itemImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@", model.goods_thumb]]];
    cell.itemSteperView.stepValue = [model.goods_number integerValue];
    
    cell.itemTitleLabel.text = model.goods_name;
    cell.priceLabel.text = model.goods_price;
    cell.tag = indexPath.row + 100;
    cell.itemCheckBox.isChecked = model.isChecked;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.f;
}

- (void)checkBox:(YXCheckBoxView *)checkBox isChecked:(BOOL)isChecked
{
    if (checkBox.tag ==  1000) {
        for (YXCartGoodsModel * model in _dataArray) {
            model.isChecked = isChecked;
        }
        [_tableView reloadData];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
