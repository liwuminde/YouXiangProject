//
//  YXLoginPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXLoginPage.h"
#import "YXRegistPage.h"
#import "YXHttpRequest.h"
#import "MBProgressHUD.h"
@interface YXLoginPage ()
{
    UIButton * _lastSelected;
    YXHttpRequest * _request;
}
@end

@implementation YXLoginPage

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
    [self configUI];
}

- (void)configUI
{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    label.font = [UIFont systemFontOfSize:17];
    label.text = @"登录";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    NSArray * btnTitles = @[@"登录", @"注册"];
    CGFloat btnHeight = 35;
    CGFloat btnWidth = frame.size.width / btnTitles.count;
    for (NSInteger i = 0; i < btnTitles.count; i++) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        btn.frame = CGRectMake(btnWidth * i, frame.size.height - 64 - btnHeight , btnWidth, btnHeight);
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_normal_bk.png"] forState:UIControlStateNormal];
        
        [btn setBackgroundImage:[UIImage imageNamed:@"btn_selected_bk.png"] forState:UIControlStateSelected];
        [btn setTitle:btnTitles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
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
    self.view.backgroundColor = [UIColor orangeColor];
}

- (void)btnClicked:(UIButton *)btn
{
    _lastSelected.selected = NO;
    
    _lastSelected = btn;
    btn.selected = YES;
    
    switch (btn.tag) {
        case 100:
        {
            [self userLogin];
        }
            break;
        case 101:
        {
            YXRegistPage * registePage = [[YXRegistPage alloc] init];
            [self.navigationController pushViewController:registePage animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)userLogin
{
    if (_request == nil) {
        _request = [[YXHttpRequest alloc] init];
        
    }
    
    NSDictionary * parm =@{@"user":_loginUserNameField.text,
                           @"password": _loginPassWordField.text};
    
    NSLog(@"%@ %@", _loginUserNameField.text, _loginPassWordField.text);
    
    [_request afPostWithUrlString:@"http://open.doushangshang.com/user.php?ac=login" parm:parm finished:^(id responseObj) {
        NSInteger code = [responseObj[@"code"] integerValue];
        
        MBProgressHUD * HUD = [MBProgressHUD showHUDAddedTo:[[UIApplication sharedApplication].delegate window].rootViewController.view animated:YES];
        
        if (code == 1) {
            HUD.labelText = @"登录成功";
            
            NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
            
            NSDictionary * msgDict = responseObj[@"msg"];
            NSString * sessionid = msgDict[@"sessionid"];
            NSString * user_id = msgDict[@"user_id"];
            
            [defaults setValue:sessionid forKey:@"sessionid"];
            [defaults setValue:user_id forKey:@"user_id"];
            [defaults synchronize];

        }else {
            HUD.labelText = @"登录失败";
        }
        
        HUD.mode = MBProgressHUDModeCustomView;
        [HUD showAnimated:YES whileExecutingBlock:^{
            sleep(10);
        } completionBlock:^{
            [HUD removeFromSuperview];
            if (code == 1) {
                [self.navigationController popViewControllerAnimated:YES];
            }
        }];
        
        NSLog(@"%@", responseObj);
        
        
    } failed:^(NSString * errorMsg) {
        
        NSLog(@"%@", errorMsg);
    }];

}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_loginUserNameField resignFirstResponder];
    [_loginPassWordField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
