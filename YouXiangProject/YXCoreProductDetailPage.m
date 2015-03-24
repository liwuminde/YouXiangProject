//
//  YXCoreProductDetailPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/29.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXCoreProductDetailPage.h"
#import "YXHttpRequest.h"
#import "UIImageView+WebCache.h"
#import "YXGoodsModel.h"
#import "YXProductDetailPage.h"

@interface YXCoreProductDetailPage ()
{
    __weak IBOutlet UILabel *_factoryLabel;
    
    __weak IBOutlet UILabel *_nameLabel;
    
    __weak IBOutlet UIImageView *_photoImageView;
    
    __weak IBOutlet UILabel *moneySymbolLabel;
    
    __weak IBOutlet UILabel *_moneyLabel;
    
    __weak IBOutlet UIImageView *_showImageView;
    
    YXHttpRequest * _request;
    UIButton * _lastSelected;
}

@end

@implementation YXCoreProductDetailPage

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
    self.view.backgroundColor = self.bkColor;
    [self setNavgationTitle:@"商城"];
    //_factoryLabel.text = @"";
    _nameLabel.text = @"";
    _moneyLabel.text = @"";
    
    CGFloat showHeight = frame.size.width * 11 / 13.0;
    
    _showImageView.frame = CGRectMake(0, frame.size.height  - showHeight  - 35 + 2, frame.size.width, showHeight);
    _photoImageView.center = CGPointMake(_photoImageView.center.x, frame.size.height - showHeight - 45);
    
    moneySymbolLabel.frame = CGRectMake(147, frame.size.height - showHeight - 65, 20, 30);
    _moneyLabel.frame = CGRectMake(168, frame.size.height - showHeight - 77, 176, 42);

    NSArray * btnTitles = @[@"订购", @"收藏"];
    CGFloat btnHeight = 35;
    CGFloat btnWidth = frame.size.width / btnTitles.count;
    for (NSInteger i = 0; i < btnTitles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(btnWidth * i, frame.size.height - 64 - btnHeight , btnWidth, btnHeight);
        [btn setBackgroundImage:[UIImage imageNamed:@"核心商城内容_07.png"] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"核心商城内容_06.png"] forState:UIControlStateSelected];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setShowsTouchWhenHighlighted:NO];
    
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenHighlighted = NO;
        if (i == 0) {
            btn.selected = YES;
            _lastSelected = btn;
        }
        
        [self.view addSubview:btn];
    }

    [self refreshData];
}
- (void)btnClicked:(UIButton *)btn
{
    _lastSelected.selected = NO;
    _lastSelected = btn;
    btn.selected = YES;
    
    switch (btn.tag) {
        case 100:
        {
            YXProductDetailPage * detail = [[YXProductDetailPage alloc] init];
            detail.goodsId = self.productId;
            [self.navigationController  pushViewController:detail animated:YES];

        }
            break;
            
        default:
            break;
    }
}

- (void)refreshData
{
    if (!_request) {
        _request = [[YXHttpRequest alloc] init];
    }
    
    NSString * path = [NSString stringWithFormat:product_detail, self.productId];
    [_request afGetWithUrlString:path finished:^(id responseObj) {
        NSDictionary * objDict = responseObj[@"msg"];
        YXGoodsModel * model = [YXGoodsModel getModelWithDict:objDict];
        
        [_photoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@",model.goods_thumb]]];
        //_factoryLabel.text = model.goods_brand;
        _nameLabel.text = model.goods_name;
        _moneyLabel.text = model.rank_price;
    } failed:^(NSString *errorMsg) {
        
    }];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
