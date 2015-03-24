//
//  YXRoomPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/2/3.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXRoomPage.h"
#import "UIView+Border.h"
#import "UIImageView+WebCache.h"
#import "YXMessageModel.h"
@interface YXRoomPage ()
{
    __weak IBOutlet UIImageView *_photoImageView;
    __weak IBOutlet UILabel *_usernameLabel;
    __weak IBOutlet UILabel *_leftTimeLabel;
    __weak IBOutlet UILabel *_roomNameLabel;
    __weak IBOutlet UILabel *_priviteLabel;
    BOOL _isLoading;
}
@end

@implementation YXRoomPage

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavgationTitle:@"现场"];
    CGRect frame = [[UIScreen mainScreen] bounds];
    [_photoImageView setBorderRadius:_photoImageView.frame.size.width / 2];
    [_photoImageView setBorderColor:[UIColor whiteColor] width:2];
    
    
    [_photoImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@", self.roomModel.face]]];
    _usernameLabel.text = self.roomModel.username;
    _roomNameLabel.text = self.roomModel.name;
    
    _tableView.frame = CGRectMake(0, 100, frame.size.width , frame.size.height - 64 - 100);
    _tableView.backgroundColor = [UIColor brownColor];
    
    _tableView.frame = CGRectZero;
    [self refreshData];

    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 100, 200, 100)];

    //[image resizableImageWithCapInsets:UIEdgeInsetsMake(44, 30, 20, 17) resizingMode:UIImageResizingModeTile];

     imageView.image =  [[UIImage imageNamed:@"chatBubble_Receiving_Solid.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(22, 33/2.f, 21/2.f, 17/2.f) resizingMode:UIImageResizingModeStretch ];
    //imageView.backgroundColor = [UIColor blackColor];
    //imageView.bounds =CGRectMake(0, 0, 200, 300);
    [self.view addSubview:imageView];
}


- (void)refreshData
{
    if (_isLoading) {
        return;
    }
    
    YXHttpRequest * request = [[YXHttpRequest alloc] init];
    
    NSDictionary * parm = @{@"roomid": self.roomModel.id,
                            @"page": @"1",
                            @"size": @"20"};

    [request afPostWithUrlString:kRoomDetail parm:parm finished:^(id responseObj) {
        
        NSInteger code =  [responseObj[@"code"] integerValue];
        
        if (code == 1) {
            NSArray * dataArray = responseObj[@"msg"][@"data"];
            
            [_dataArray addObjectsFromArray:[YXMessageModel getModelsFromArray:dataArray]];
        }
        
    } failed:^(NSString *errorMsg) {
        
    }];

}

- (void)loadData
{
    if (_isLoading) {
        return;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
