//
//  YXIndexPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXIndexPage.h"
#import "TCSliderView.h"
#import "YXLoginPage.h"
#import "YXMovePage.h"
#import "TCAlertWindow.h"
#import "YXAddressSelectedView.h"
@interface YXIndexPage ()<TCSliderViewDelegate>
{
    TCSliderView * _sliderView;
    
}
@end

@implementation YXIndexPage

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
    [self configUI];
    
    
}

- (void)configUI
{
    CGRect frame = [[UIScreen mainScreen]bounds];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = nil;
    CGFloat leftMargin = 5;
    CGFloat topMargin = 7;
    CGFloat btnWidth = (frame.size.width - 4 * leftMargin)/ 3;
    CGFloat btnHeight = btnWidth;
    CGFloat sliderHeight = frame.size.height - 64 - btnHeight * 2 - topMargin * 2 - leftMargin;

    
    _sliderView = [[TCSliderView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, sliderHeight)];;
    _sliderView.imageNameArray = @[@"主页海报1.jpg",@"主页海报2.jpg",@"主页海报3.jpg",@"主页海报4.jpg",@"主页海报5.jpg"];
    _sliderView.delegate = self;
    [self.view addSubview:_sliderView];
    //直接设置
    
    for (NSInteger i = 0; i < 6; i++) {
        NSInteger row = i / 3;
        NSInteger column = i % 3;
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_%d", i + 1]] forState:UIControlStateNormal];
        CGFloat firstMargin = 0;
        if (i == 0) {
            firstMargin = leftMargin;
        }
        btn.frame = CGRectMake(leftMargin + (leftMargin + btnWidth) * column, sliderHeight + topMargin + (btnHeight+ leftMargin) * row, btnWidth, btnHeight) ;
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 100 + i;
        [self.view addSubview:btn];
    }

    UIButton * itemBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [itemBtn setBackgroundImage:[UIImage imageNamed:@"home_right"] forState:UIControlStateNormal];
    itemBtn.frame = CGRectMake(0, 0,20, 15);
    [itemBtn addTarget:self action:@selector(rightItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:itemBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)sliderView:(TCSliderView *)sliderView didPresentedWithIndex:(NSInteger)index
{
    
}

//- (void)btnClicked:(UIButton *)btn
//{
//    NSInteger index = btn.tag - 100;
//    NSArray * viewControllerArray = @[@"YXMovePage", @"YXMallPage", @"YXScenePage"];
//    if (index >= viewControllerArray.count) {
//        return;
//    }
//    Class cls = NSClassFromString(viewControllerArray[index]);
//    UIViewController * vc = [[cls alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
//}

- (void)btnClicked:(UIButton *)btn
{
    NSInteger index = btn.tag - 100;
    NSArray *viewControllerArray = @[@"YXMovePage",@"YXMallPage",@"YXScenePage"];
    if (index >= viewControllerArray.count) {
        return;
    }
    Class cls = NSClassFromString(viewControllerArray[index]);
    UIViewController *vc = [[cls alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)rightItemClicked:(UIButton *)btn
{
    YXLoginPage * login = [[YXLoginPage alloc] init];
    [self.navigationController pushViewController:login animated:YES];
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
