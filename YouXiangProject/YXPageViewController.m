//
//  YXPageViewController.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/29.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXPageViewController.h"

@interface YXPageViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate>
{
    UIPageViewController * _pageViewController;
    NSMutableArray * _pageContents;
    UIButton * _lastSelected;
    
    NSInteger _currentPage;
}
@end

@implementation YXPageViewController

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
    
    //变量初始化
    _pageContents = [NSMutableArray array];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    NSArray * btnTitels = @[@"电影", @"综艺"];
    CGFloat btnWidth = frame.size.width / btnTitels.count;
    CGFloat btnHeight = 35;
    for (NSInteger i = 0; i < btnTitels.count; i++) {
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(btnWidth * i, 0, btnWidth, btnHeight);
        btn.tag = 100 + i;
        [btn setTitle:btnTitels[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.view addSubview:btn];
        
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, btnHeight - 3, btnWidth, 3)];
        label.backgroundColor = [UIColor blackColor];
        label.tag = 200;
        [btn addSubview:label];
        label.hidden = YES;
        if (i == 0) {
            btn.selected = YES;
            _lastSelected =  btn;
            label.hidden = NO;
        }
        
        [btn addTarget:self action:@selector(meauBarItemClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    _pageViewController.automaticallyAdjustsScrollViewInsets = NO;
    _pageViewController.view.frame = CGRectMake(0, 35, frame.size.width , frame.size.height);
    _pageViewController.delegate = self;
    _pageViewController.dataSource = self;
    
    [self.view addSubview:_pageViewController.view];
    [self addChildViewController:_pageViewController];
    
}

- (void)meauBarItemClicked:(UIButton *)btn
{
    UILabel * label = (UILabel *)[_lastSelected viewWithTag:200];
    label.hidden = YES;
    label = (UILabel *)[btn viewWithTag:200];
    label.hidden = NO;
    _lastSelected = btn;
    [self meauBarItemIndexChanged:btn.tag - 100];
}

- (void)meauBarItemIndexChanged:(NSInteger)index
{
    [self setCurrentPage:index];
    //NSLog(@"请重写此方法%s",__FUNCTION__);
}


#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSInteger index = -1;
    for (NSInteger i = 0; i < _pageContents.count; i++) {
        if (_pageContents[i] == viewController) {
            index = i;
        }
    }
    
    if (index <= 0) {
        return nil;
    }else {
        _currentPage = index - 1;
        return _pageContents[index - 1];
    }
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSInteger index = -1;
    for (NSInteger i = 0; i < _pageContents.count; i++) {
        if (_pageContents[i] == viewController) {
            index = i;
        }
    }
    
    if (index >= _pageContents.count - 1) {
        return nil;
    }else {
        _currentPage = index + 1;
        //[self setCurrentMeunItem:_currentPage];
        return _pageContents[index + 1];
    }
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        UIViewController * prev = [previousViewControllers lastObject];
        UIViewController * cur = [pageViewController.viewControllers lastObject];
        [self setCurrentMeunItem:cur.view.tag - 1000];

    }
}

#pragma mark - 对外方法
- (void)setPageContents:(NSArray *)array
{
    [_pageContents removeAllObjects];
    for (NSInteger i = 0; i < array.count; i++) {
        UIViewController * vc = array[i];
        vc.view.tag = 1000 + i;
        [_pageContents addObject:vc];
    }
    
    [_pageViewController setViewControllers:@[_pageContents[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
    }];
}
- (void)setCurrentPage:(NSInteger) index
{
    if (index >= _pageContents.count || index < 0) {
        NSLog(@"无效的索引%s",__FUNCTION__);
        return ;
    }
    
    UIViewController * vc = _pageContents[index];
    
    UIPageViewControllerNavigationDirection direction = UIPageViewControllerNavigationDirectionForward;
    
    if (_currentPage > index ) {
        direction = UIPageViewControllerNavigationDirectionForward;
    }else {
        direction = UIPageViewControllerNavigationDirectionReverse;
    }
    
    [_pageViewController setViewControllers:@[vc] direction:direction animated:YES completion:^(BOOL finished) {
        
    }];
    
    _currentPage = index;
    [self setCurrentMeunItem:_currentPage];
}

- (void)setMenuBarItemTitles:(NSArray *)array
{
    for (NSInteger i = 0; i < array.count; i++) {
        
        UIButton * button = (UIButton *)[self.view viewWithTag:100 + i];
        
        if (button) {
            [button setTitle:array[i] forState:UIControlStateNormal];
        }
    }
}

- (void)setCurrentMeunItem:(NSInteger) index
{
    UIButton * button = (UIButton *)[self.view viewWithTag:100 + index];
    

    if (button) {
        UILabel * label = (UILabel *)[_lastSelected viewWithTag:200];
        label.hidden = YES;
        label = (UILabel *)[button viewWithTag:200];
        label.hidden = NO;
        _lastSelected = button;

    }

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
