//
//  YXOrderSubmitPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXOrderSubmitPage.h"

@interface YXOrderSubmitPage ()
{
    
    __weak IBOutlet UILabel *_orderPriceLabel;
    
    __weak IBOutlet UIView *_firstPayView;
    
    __weak IBOutlet UIView *_secondePayView;
}
@end

@implementation YXOrderSubmitPage

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
    self.view.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:1];
    [self setNavgationTitle:@"在线支付"];
    
    _orderPriceLabel.text = [NSString  stringWithFormat:@"支付金额￥%@元", self.totalPrice];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
