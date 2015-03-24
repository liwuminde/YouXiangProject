//
//  YXMallPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/29.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXMallPage.h"
#import "YXCoreProductPage.h"
#import "YXPlatformProductPage.h"
@interface YXMallPage ()

@end

@implementation YXMallPage

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
    [self setNavgationTitle:@"商城"];
    [self setMenuBarItemTitles:@[@"核心产品", @"平台产品"]];
    
    YXCoreProductPage * coreProductPage = [[YXCoreProductPage alloc] init];
    
    YXPlatformProductPage * platformProductPage = [[YXPlatformProductPage alloc] init];
    
    [self setPageContents:@[coreProductPage, platformProductPage]];
     
}


//- (void)meauBarItemIndexChanged:(NSInteger)index
//{
//   // [self setCurrentPage:index];
//}




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
