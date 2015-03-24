//
//  YXRegistPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXRegistPage.h"
#import "YXPhoneRegisterView.h"
#import "YXEmailRegisterView.h"
#import "UIButton+setBorderRadius.h"
#import "YXHttpRequest.h"
#import "MBProgressHUD.h"
@interface YXRegistPage ()
{
    YXPhoneRegisterView * _phoneRegister;
    YXEmailRegisterView * _emailRegister;
    UIButton * _lastSelected;
    YXHttpRequest * _request;
}
@end

@implementation YXRegistPage

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
    [self configUI];
    
}

- (void)configUI
{
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self setNavgationTitle:@"注册"];
    CGRect frame = [[UIScreen mainScreen]bounds];
    _phoneRegister = [[[NSBundle mainBundle]loadNibNamed:@"YXPhoneRegisterView" owner:self options:nil] lastObject];
    _phoneRegister.frame = CGRectMake(0, 60, frame.size.width, 140);
    [self.view addSubview:_phoneRegister];
    [_phoneRegister.registerGetVerificationCodeBtn setBorderRadius:5];

    _emailRegister = [[[NSBundle mainBundle]loadNibNamed:@"YXEmailRegisterView" owner:self options:nil] lastObject];
    _emailRegister.frame = CGRectMake(0, 60, frame.size.width, 140);
    
    NSArray * btnTitles = @[@"手机注册", @"邮箱注册"];
    CGFloat btnHeight = 40;
    CGFloat leftMargin = 10;
    CGFloat btnWidth = (frame.size.width - leftMargin * btnTitles.count) / btnTitles.count;
    for (NSInteger i = 0; i < btnTitles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(btnWidth * i + leftMargin, 10 , btnWidth, btnHeight);
                [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [btn setShowsTouchWhenHighlighted:NO];
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.adjustsImageWhenHighlighted = NO;
        btn.backgroundColor = [UIColor colorWithRed:0.93 green:0.16 blue:0.13 alpha:1];

        //[btn setBorderRadius:5];
        if (i == 0) {
            btn.selected = YES;
            btn.backgroundColor = [UIColor whiteColor];
            _lastSelected = btn;
        }
        
        [self.view addSubview:btn];
    }
    
    UIButton * registerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    registerBtn.frame = CGRectMake(85, 200, 150, 40);
    [registerBtn setTitle:@"注册" forState:UIControlStateNormal];
    [registerBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [registerBtn setBorderRadius:5];
    registerBtn.backgroundColor = [UIColor colorWithRed:0.93 green:0.16 blue:0.13 alpha:1];
    registerBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [registerBtn addTarget:self action:@selector(registerBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:registerBtn];
    
}

- (void)btnClicked:(UIButton *)btn
{
    _lastSelected.backgroundColor = [UIColor colorWithRed:0.93 green:0.16 blue:0.13 alpha:1];
    _lastSelected.selected = NO;
    btn.backgroundColor = [UIColor whiteColor];
    btn.selected = YES;
    _lastSelected = btn;
    switch (btn.tag) {
        case 100:
        {
            [self.view addSubview:_phoneRegister];
            [_emailRegister removeFromSuperview];
        }
            break;
        case 101:
        {
            [self.view addSubview:_emailRegister];
            [_phoneRegister removeFromSuperview];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)registerBtnClicked
{
    if (_lastSelected.tag == 101) {
        
        if (_request == nil) {
            _request = [[YXHttpRequest alloc] init];
            
        }
        
        NSDictionary * parm =@{@"user":_emailRegister.usernameField.text,
                               @"password": _emailRegister.passwordField.text,
                               @"conform_password": _emailRegister.passwordField.text};
        
        [_request afPostWithUrlString:@"http://open.doushangshang.com/user.php?ac=register" parm:parm finished:^(id responseObj) {
            NSInteger code = [responseObj[@"code"] integerValue];
            
            MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window].rootViewController.view animated:YES];
            
            if (code == 1) {
                HUD.labelText = @"注册成功,请登录";
            }else {
                HUD.labelText = @"注册失败,请再次尝试";
            }
        
           
            HUD.mode = MBProgressHUDModeCustomView;
            [HUD showAnimated:YES whileExecutingBlock:^{
                sleep(1);
            } completionBlock:^{
                [HUD removeFromSuperview];
                if (code == 1) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
            }];

            
            
        } failed:^(NSString * errorMsg) {
            
            NSLog(@"%@", errorMsg);
        }];

    }
    
    [_emailRegister.usernameField resignFirstResponder];
    [_emailRegister.passwordField resignFirstResponder];
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_emailRegister.usernameField resignFirstResponder];
    [_emailRegister.passwordField resignFirstResponder];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
