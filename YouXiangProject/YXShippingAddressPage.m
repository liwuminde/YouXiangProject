//
//  YXShippingAddressPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/2.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXShippingAddressPage.h"
#import "YXReginModel.h"
#import "YXUserDefaultsHelper.h"
#import "YXAddressSelectedView.h"
#import "TCAlertWindow.h"
#import "YXScrollView.h"
#import "MBProgressHUD.h"
@interface YXShippingAddressPage () <UITextFieldDelegate, UIScrollViewDelegate>
{
    __weak IBOutlet UITextField *_consigneeField;
    __weak IBOutlet UITextField *_phoneNoField;
    __weak IBOutlet UITextField *_emalField;
    __weak IBOutlet UITextField *_reginField;
    __weak IBOutlet UITextField *_postNoField;
    __weak IBOutlet UITextField *detailAddressField;
    __weak IBOutlet UILabel *_reginMashLabel;
    
    __weak IBOutlet UIScrollView *_scrollView;
    
    __weak IBOutlet UIButton *_saveBtn;
    UITextField * _lastTextField;
}
@end

@implementation YXShippingAddressPage

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
    [self setNavgationTitle:@"收货地址"];
    [self updateRegin:nil];
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reginTapClicked:)];
    //_reginField.enabled = NO;
    [_reginMashLabel addGestureRecognizer:tap];
    _reginMashLabel.userInteractionEnabled = YES;
    
    _consigneeField.delegate = self;
    _phoneNoField.delegate = self;
    _emalField.delegate = self;
    _reginField.delegate = self;
    _postNoField.delegate = self;
    detailAddressField.delegate = self;
    
    _scrollView.delegate = self;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.frame.size.height + 1);
    
    [_saveBtn addTarget:self action:@selector(saveBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    _consigneeField.text = [defaults objectForKey:@"defaultConsignee"];
    _phoneNoField.text = [defaults objectForKey:@"defaultPhone"];
    _emalField.text = [defaults objectForKey:@"defaultEmail"];
    _postNoField.text = [defaults objectForKey:@"defaultPost"];
    detailAddressField.text = [defaults objectForKey:@"defaultDetailAddress"];
}

- (void)saveBtnClicked
{
    if (_consigneeField.text.length  == 0) {
        [self alertView:@"请填写收货人姓名"];
        return;
    }
    if (_phoneNoField.text.length  == 0) {
        [self alertView:@"请填写电话号码"];
        return;
    }
    if (_emalField.text.length  == 0) {
        [self alertView:@"请填写Email"];
        return;
    }
    if (_postNoField.text.length  == 0) {
        [self alertView:@"请填写邮政编码"];
        return;
    }
    if (detailAddressField.text.length  == 0) {
        [self alertView:@"请填写详细信息"];
        return;
    }

    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:_consigneeField.text forKey:@"defaultConsignee"];
    [defaults setObject:_phoneNoField.text forKey:@"defaultPhone"];
    [defaults setObject:_emalField.text forKey:@"defaultEmail"];
    [defaults setObject:_postNoField.text forKey:@"defaultPost"];
    [defaults setObject:detailAddressField.text forKey:@"defaultDetailAddress"];
    [defaults synchronize];
    
    [self.navigationController popViewControllerAnimated:YES];
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

- (void)reginTapClicked:(UITapGestureRecognizer *)tap
{
    YXAddressSelectedView * address = [[YXAddressSelectedView alloc] initWithFrame:CGRectZero];
    [address addTaget:self action:@selector(updateRegin:)];
    TCAlertWindow * alert = [[TCAlertWindow alloc] initWithCustomView:address];
    address.alertWindow = alert;
    
}

-(void)updateRegin:(NSString *)addr
{
    NSArray * addrArray = [YXUserDefaultsHelper getDefaultAddress];
    if (addrArray.count == 3) {
        YXReginModel * province = addrArray[0];
        YXReginModel * city = addrArray[1];
        YXReginModel * regins = addrArray[2];
        NSString * addrStr = [NSString stringWithFormat:@"中国%@省%@市%@", province.region_name, city.region_name, regins.region_name];
        _reginField.text = addrStr;
    }else{
        _reginField.text = @"";
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _lastTextField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
  
}

- (void)YXScrollViewTouchBegin
{
    [_lastTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [_lastTextField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
