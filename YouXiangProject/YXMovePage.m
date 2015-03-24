//
//  YXMovePage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/27.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXMovePage.h"
#import "TCSliderView.h"
#import "YXHttpRequest.h"
#import "YXVideoModel.h"
#import "YXMoiveCell.h"
#import "UIImageView+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UMSocial.h"
#import "MoviePlayerViewController.h"
#import "YXCommentPage.h"

@interface YXMovePage ()<UITableViewDataSource, UITableViewDelegate,YXMoiveCellDelegate,UMSocialDataDelegate,UMSocialUIDelegate,MoviePlayerViewControllerDataSource>
{
    TCSliderView * _sliderView;
    UITableView * _tableView;//tabelView
    NSMutableArray * _dataArray;//data
    UIButton * _lastSelected;//表示button
    YXHttpRequest * _request;//请求
    NSInteger  _page;//
    NSInteger _size;//
    NSInteger _cateid;//
    MPMoviePlayerViewController * _movePlayer;//播放器
}
@end

@implementation YXMovePage

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
    _cateid = 1;
    _size = 10;
    _page = 1;
    [self configUI];
    
}

- (void) configUI
{
    [self setNavgationTitle:@"影视"];
    _dataArray = [NSMutableArray array];
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.view.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    
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
        
        [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, frame.size.width, frame.size.height - 40 - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:0.93 green:0.93 blue:0.93 alpha:1];
    [self.view addSubview:_tableView];
    
    _sliderView = [[TCSliderView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 200)];
    [_sliderView setImageNameArray:@[@"影视1.jpg", @"影视2.jpg",@"影视3.jpg",@"影视4.jpg", @"影视4.jpg"]];
    
  
    [self refreshData];
}

- (void)refreshData
{
    if (_request == nil) {
        _request = [[YXHttpRequest alloc] init];
    }
    
    NSString * path = [NSString stringWithFormat:@"http://open.doushangshang.com/video.php?ac=list&page=%ld&size=%ld&cateid=%ld",_page,_size,_cateid];
    
    [_request afGetWithUrlString:path finished:^(id responseObj) {
        [_dataArray removeAllObjects];
        NSDictionary * msgDict = responseObj[@"msg"];
        NSArray * listArray = msgDict[@"data"];
        [_dataArray addObjectsFromArray:[YXVideoModel getModelsFromArray:listArray]];
        [_tableView reloadData];
        
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (void)loadData
{
    
}

- (void)btnClicked:(UIButton *)btn
{
    
    if (_lastSelected == btn) {
        return;
    }
    
    UILabel * label = (UILabel *)[_lastSelected viewWithTag:200];
    label.hidden = YES;
    label = (UILabel *)[btn viewWithTag:200];
    label.hidden = NO;
    _lastSelected = btn;
    
    _cateid = btn.tag - 100 + 1;
    
    [self refreshData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXMoiveCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YXMoiveCell"];
    
    if (cell == nil) {
        cell =  [[[NSBundle mainBundle] loadNibNamed:@"YXMoiveCell" owner:self options:nil] lastObject];
    }
    
    YXVideoModel * model = [_dataArray objectAtIndex:indexPath.row];
    
    [cell.moiveImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@", model.pic]]];
    cell.moiveTitleLabel.text = [NSString stringWithFormat:@" %@",model.title];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.indexPath = indexPath;
    cell.delegate = self;
    cell.upCount = [model.lovecount integerValue];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 209.f;
}

- (void)sharedButtonClicked:(NSIndexPath *)indexPath
{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"54c74e24fd98c5ca130008ad"
                                      shareText:@"你要分享的文字"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:@[UMShareToSina, UMShareToTencent, UMShareToWechatSession, UMShareToWechatTimeline, UMShareToQzone, UMShareToQQ, UMShareToRenren ,UMShareToDouban, UMShareToEmail,UMShareToSms]
     
                                       delegate:self];
    
}

- (void)cellClicked:(NSIndexPath *)indexPath
{
    NSLog(@"tap");
    YXVideoModel * model = _dataArray[indexPath.row];
    
    NSString * path = [NSString stringWithFormat:@"http://open.doushangshang.com/video.php?ac=video_detail&id=%@", model.id];
  
    [_request afGetWithUrlString:path finished:^(id responseObj) {
       
        NSString * playUrl = responseObj[@"msg"][@"data"][@"play"][@"url"];
        NSLog(@"%@", playUrl);
        NSURL *url = [NSURL URLWithString:playUrl];
        MoviePlayerViewController *movieVC = [[MoviePlayerViewController alloc]initNetworkMoviePlayerViewControllerWithURL:url movieTitle:model.title];
        movieVC.datasource = self;
        [self presentViewController:movieVC animated:YES completion:nil];

        
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (NSDictionary *)nextMovieURLAndTitleToTheCurrentMovie
{
    return nil;
}
- (NSDictionary *)previousMovieURLAndTitleToTheCurrentMovie
{
    return nil;
}
- (BOOL)isHaveNextMovie
{
    return NO;
}
- (BOOL)isHavePreviousMovie
{
    return NO;
}

//点赞
- (void)upButtonClicked:(NSIndexPath *)indexPath State:(BOOL)state
{
    
}

//评论
- (void)commentClicked:(NSIndexPath *)indexPath
{
    YXVideoModel * model = _dataArray[indexPath.row];
    YXCommentPage * commentPage = [[YXCommentPage alloc] init];
    commentPage.videoid = model.id;
    [self.navigationController pushViewController:commentPage animated:YES];
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
