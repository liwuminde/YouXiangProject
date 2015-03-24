//
//  YXOrderFormInfoPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXOrderFormInfoPage.h"
#import "YXShoppingCartItemCell.h"
#import "YXCartGoodsModel.h"
#import "YXCartGoodsModel.h"
#import "YXHttpRequest.h"
#import "UIImageView+WebCache.h"
#import "YXOrderGoodsCell.h"
#import "YXOrderSubmitPage.h"
#import "YXPayModeSelectView.h"
#import "TCAlertWindow.h"
#import "YXShippingAddressPage.h"
#import "YXReginModel.h"
#import "YXUserDefaultsHelper.h"
#import "MBProgressHUD.h"
@interface YXOrderFormInfoPage () <UITableViewDataSource, UITableViewDelegate,YXPayModeSelectViewDelegate>
{
    
    __weak IBOutlet UIView *_bottomView;
    __weak IBOutlet UIView *_topView;
    __weak IBOutlet UILabel *_priceLabel;
    __weak IBOutlet UIButton *_submitButton;
    __weak IBOutlet UIView *_firstView;
    __weak IBOutlet UIView *_secondView;
    __weak IBOutlet UIView *_thirdView;
    __weak IBOutlet UILabel *_payModeLabel;
    __weak IBOutlet UILabel *_addressLabel;
    
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    NSString * _totalPrice;
}
@end

@implementation YXOrderFormInfoPage

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
    [self setNavgationTitle:@"订单信息"];
    _dataArray = [NSMutableArray array];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 64 - _bottomView.frame.size.height) style:UITableViewStylePlain];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    [self.view addSubview:_tableView];
    
    [_topView removeFromSuperview];
    _tableView.tableHeaderView = _topView;
    
    _bottomView.center = CGPointMake(_bottomView.center.x, (frame.size.height- 64 - _bottomView.frame.size.height/2));
    [_submitButton addTarget:self action:@selector(submitButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    NSArray * viewArray = @[_firstView, _secondView, _thirdView];
    
    for (NSInteger i = 0; i < viewArray.count; i++) {
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
        UIView * tempView = viewArray[i];
        tempView.tag = 100 + i;
        [tempView addGestureRecognizer:tap];
    }
    
    NSArray * addrArray = [YXUserDefaultsHelper getDefaultAddress];
    if (addrArray.count == 3) {
        YXReginModel * province = addrArray[0];
        YXReginModel * city = addrArray[1];
        YXReginModel * regins = addrArray[2];
        NSString * addrStr = [NSString stringWithFormat:@"中国%@省%@市%@", province.region_name, city.region_name, regins.region_name];
        _addressLabel.text = addrStr;
    }else{
        _addressLabel.text = @"";
    }
    
    [self refreshData];
}

- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    switch (tap.view.tag) {
        case 100:
        {
            YXPayModeSelectView * payModeView = [[[NSBundle mainBundle] loadNibNamed:@"YXPayModeSelectView" owner:self options:nil] lastObject];
            TCAlertWindow * alertWindow = [[TCAlertWindow alloc] initWithCustomView:payModeView];
            payModeView.delegate = self;
            payModeView.alertWindow = alertWindow;
            [alertWindow setTitle:@"请选择支付方式"];
        }
            break;
        case 101:
            
            break;
        case 102:
        {
            YXShippingAddressPage * shippingAddressPage = [[YXShippingAddressPage alloc] init];
            
            [self.navigationController pushViewController:shippingAddressPage animated:YES];
        }
            
            break;
            
        default:
            break;
    }
}

- (void)submitButtonClicked
{
    [self submitOrder];
}

- (void)submitOrder
{
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * consignee = [defaults objectForKey:@"defaultConsignee"];
    NSString * phoneNo = [defaults objectForKey:@"defaultPhone"];
    NSString * emal = [defaults objectForKey:@"defaultEmail"];
    NSString * postNo = [defaults objectForKey:@"defaultPost"];
    NSString * detail = [defaults objectForKey:@"defaultDetailAddress"];
    NSString * sessionid = [defaults objectForKey:@"sessionid"];
    NSString * cartsesskey = [defaults objectForKey:@"cartsesskey"];
    
    NSArray * array = [YXUserDefaultsHelper getDefaultAddress];
    if (array == nil) {
        [self alertView:@"请输入送货地区"];
        return;
    }
    
    YXReginModel * province = array[0];
    YXReginModel * city = array[1];
    YXReginModel * regins = array[2];
    
    NSDictionary * parm = @{@"sesskey":sessionid,
                            @"cartsesskey":cartsesskey,
                            @"consignee":consignee,
                            @"country": @"1",
                            @"province": province.region_id,
                            @"city":city.region_id,
                            @"district":regins.region_id,
                            @"email":emal,
                            @"address":detail,
                            @"zipcode":postNo,
                            @"tel":phoneNo
                            };
    
    NSLog(@"%@", parm);
    
    YXHttpRequest * request = [[YXHttpRequest alloc] init];
    _submitButton.enabled = NO;
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window].rootViewController.view animated:YES];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = @"正在提交订单...";
    [HUD show:YES];
    [request afPostWithUrlString:kSubmitOrder parm:parm finished:^(id responseObj) {
        NSInteger code = [responseObj[@"code"] integerValue];
        
        if (code == 1) {
            YXOrderSubmitPage * orderSubmit = [[YXOrderSubmitPage alloc] init];
            orderSubmit.totalPrice = _totalPrice;
            [self.navigationController pushViewController:orderSubmit animated:YES];
        }
        
         _submitButton.enabled = YES;
        [HUD removeFromSuperview];
    } failed:^(NSString *errorMsg) {
         _submitButton.enabled = YES;
        [HUD removeFromSuperview];
    }];
}

- (void)alertView:(NSString *)content
{
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window].rootViewController.view animated:YES];
    HUD.mode = MBProgressHUDModeCustomView;
    HUD.labelText = content;
    [HUD showAnimated:YES whileExecutingBlock:^{
        sleep(1);
    } completionBlock:^{
        [HUD removeFromSuperview];
    }];
}

- (void)refreshData
{
    YXHttpRequest * request = [[YXHttpRequest alloc] init];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    NSString * sesskey = [defaults objectForKey:@"cartsesskey"];
    NSString * path = [NSString stringWithFormat:getcart ,sesskey];
    _submitButton.userInteractionEnabled = NO;
    [request afGetWithUrlString:path finished:^(id responseObj) {
        NSInteger code = [responseObj[@"code"] integerValue];
        
        if (code == 1) {
            NSArray * dataArray = responseObj[@"msg"][@"data"][@"goods_list"];
            
            [_dataArray addObjectsFromArray:[YXCartGoodsModel getModelsFromArray:dataArray]];
            
            _totalPrice = [responseObj[@"msg"][@"data"][@"total"][@"goods_amount"] stringValue];
            
            _priceLabel.text = [NSString stringWithFormat:@"合计：￥%@", _totalPrice];
            
            [_tableView reloadData];
            _submitButton.userInteractionEnabled =  YES;
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXOrderGoodsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YXOrderGoodsCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YXOrderGoodsCell" owner:self options:nil] lastObject];
    }
    YXCartGoodsModel * model = _dataArray[indexPath.row];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.orderGoodsImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@", model.goods_thumb]]];
    cell.orderSteperView.stepValue = [model.goods_number integerValue];
    
    cell.orderGoodsTitelLabel.text = model.goods_name;
    cell.orderGoodsPriceLabel.text = model.goods_price;
    cell.tag = indexPath.row + 100;
    return cell;
}

- (void)selectedPayModel:(NSString *)payModeName tag:(NSInteger)tag
{
    _payModeLabel.text = payModeName;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
