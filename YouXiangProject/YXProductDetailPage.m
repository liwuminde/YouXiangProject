//
//  YXProductDetailPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/29.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXProductDetailPage.h"
#import "YXSteperView.h"
#import "TCSliderView.h"
#import "YXHttpRequest.h"
#import "YXGoodsModel.h"
#import "YXShoppingCartPage.h"
#import "MBProgressHUD.h"
#import "YXAddressSelectedView.h"
#import "TCAlertWindow.h"
#import "YXUserDefaultsHelper.h"
@interface YXProductDetailPage ()
{
    __weak IBOutlet UILabel *_priceLabel;
    __weak IBOutlet UILabel *_specLabel;
    __weak IBOutlet UILabel *_addressLbel;
    __weak IBOutlet UILabel *_postageLabel;
    __weak IBOutlet UIButton *_buyButton;
    __weak IBOutlet UIButton *_collectButton;
    __weak IBOutlet UILabel *_titleLabel;
    YXSteperView * _steperView;
    TCSliderView * _sliderView;
}
@end

@implementation YXProductDetailPage

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
     
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavgationTitle:@"商品详情"];
    CGRect frame= [[UIScreen mainScreen]bounds];
    _steperView = [[YXSteperView alloc] initWithFrame:CGRectMake(71, 332, 70, 20)];
    [self.view addSubview:_steperView];
    _steperView.stepValue = 1;
    
    _sliderView = [[TCSliderView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 228)];
   
    [self.view addSubview:_sliderView];
    
    _buyButton.center = CGPointMake(_buyButton.center.x, (frame.size.height - 64 - _buyButton.frame.size.height/2));
    [_buyButton addTarget:self action:@selector(buyClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_addressLbel.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0, 0, 0, 0.3 });
    [_addressLbel.layer setBorderColor:colorref];//边框颜色
    [self.view sendSubviewToBack:_sliderView];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
    [_addressLbel addGestureRecognizer:tap];
    _addressLbel.userInteractionEnabled = YES;
    [self refreshData];
    
    NSArray * addrArray = [YXUserDefaultsHelper getDefaultAddress];
    if (addrArray.count == 3) {
        YXReginModel * province = addrArray[0];
        YXReginModel * city = addrArray[1];
        YXReginModel * regins = addrArray[2];
        NSString * addrStr = [NSString stringWithFormat:@"中国%@省%@市%@", province.region_name, city.region_name, regins.region_name];
        _addressLbel.text = addrStr;
    }else{
        _addressLbel.text = @"";
    }
    
}

- (void)tapClicked:(UITapGestureRecognizer *)tap
{
    YXAddressSelectedView * address = [[YXAddressSelectedView alloc] initWithFrame:CGRectZero];
    [address addTaget:self action:@selector(updateAddress:)];
    TCAlertWindow * alert = [[TCAlertWindow alloc] initWithCustomView:address];
    address.alertWindow = alert;
}

- (void)updateAddress:(NSString *)addr
{
    _addressLbel.text = addr;
}

- (void)refreshData
{
    YXHttpRequest * request = [[YXHttpRequest alloc] init];
    
    NSString * path = [NSString stringWithFormat:product_detail, self.goodsId];
    
    [request afGetWithUrlString:path finished:^(id responseObj) {
        
        NSDictionary * dict = responseObj[@"msg"];
        YXGoodsModel * model = [YXGoodsModel getModelWithDict:dict];
        
        if (model) {
            _priceLabel.text = [NSString stringWithFormat:@"￥%@",model.shop_price];
            _specLabel.text = model.goods_weight;
            _sliderView.urlStringArray=@[[NSString stringWithFormat:@"http://doushangshang.com/%@",model.goods_img]];
            _titleLabel.text = [NSString stringWithFormat:@" %@",model.goods_name];
        }

    } failed:^(NSString *errorMsg) {
        
    }];
}

- (void)buyClicked:(UIButton *)btn
{
    YXHttpRequest *request = [[YXHttpRequest alloc]init];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * cartsesskey = [defaults objectForKey:@"cartsesskey"];
    
    NSDictionary * parm;
    if (cartsesskey) {
        parm = @{@"goods_id":self.goodsId,
                                @"num":[NSString stringWithFormat:@"%ld", _steperView.stepValue],
                                @"cartsesskey": cartsesskey};
    }else{
        parm = @{@"goods_id":self.goodsId,
                                @"num":[NSString stringWithFormat:@"%ld", _steperView.stepValue]
                                };
    }
    
    btn.enabled = NO;
    
    MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window].rootViewController.view animated:YES];
    HUD.labelText = @"正在添加到购物车...";
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
    [request afPostWithUrlString:addtocart parm:parm finished:^(id responseObj) {
        
        
         NSInteger code = [responseObj[@"code"] integerValue];
        if (code == 1) {
            HUD.mode = MBProgressHUDModeCustomView;
            HUD.labelText =@"成功添加，正转到购物车..";
            
            NSString * cartsessionid = responseObj[@"msg"][@"cartsessionid"];
            [defaults setObject:cartsessionid forKey:@"cartsesskey"];
            [defaults synchronize];
            
            NSLog(@"%@", responseObj);
            
        }else {
            HUD.labelText = @"添加失败!";
        }
        
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(1);
        } completionBlock:^{
            if (code == 1) {
                YXShoppingCartPage * shoppingCart = [[YXShoppingCartPage alloc] init];
                [self.navigationController pushViewController:shoppingCart animated:YES];
            }
            [HUD removeFromSuperview];
             btn.enabled = YES;
        }];
        
    } failed:^(NSString *errorMsg) {
        btn.enabled = YES;
        [HUD removeFromSuperview];
    }];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
