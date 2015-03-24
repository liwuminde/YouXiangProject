//
//  YXBaseViewController.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXBaseViewController.h"

@interface YXBaseViewController ()
{
}
@end

@implementation YXBaseViewController

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
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:0.19 green:0.19 blue:0.19 alpha:1];
    self.navigationController.navigationBar.translucent = NO;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 44)];
    label.font = [UIFont systemFontOfSize:17];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    self.navigationItem.titleView = label;

    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@"navbar_left_item"] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 12, 15);
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    [btn addTarget:self action:@selector(leftItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton * itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemBtn setBackgroundImage:[UIImage imageNamed:@"home_right"] forState:UIControlStateNormal];
    itemBtn.frame = CGRectMake(0, 0,20, 15);
    [itemBtn addTarget:self action:@selector(rightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)leftItemClicked:(UIButton *)btn
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)rightItemClicked:(UIButton *)btn
{
    
}

- (void)setNavgationTitle:(NSString *)title
{
    UILabel * label = (UILabel *) self.navigationItem.titleView;
    label.text = title;
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
