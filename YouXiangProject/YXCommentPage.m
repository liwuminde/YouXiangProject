//
//  YXCommentPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/28.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXCommentPage.h"
#import "UIImageView+WebCache.h"
#import "YXCommentCell.h"
#import "YXCommentModel.h"
#import "YXHttpRequest.h"
#import "YXLoginPage.h"
@interface YXCommentPage () <UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate>
{
    //UITableView * _tableView;
    //NSMutableArray * _dataArray;
    UIView * _inputBar;
    UITextField * _inputField;
    YXHttpRequest * _request;
    
    NSString * _replayString;
}
@end

@implementation YXCommentPage

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

    CGRect frame = [[UIScreen mainScreen]bounds];
    _tableView.frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 64 - 40);
    [self refreshData];
    
    CGFloat inputBarHeight =  40;
    _inputBar = [[UIView alloc] initWithFrame:CGRectMake(-1, frame.size.height - inputBarHeight - 64, frame.size.width + 2, inputBarHeight)];
    _inputBar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_inputBar];
    
    UIImageView * commentIcon = [[UIImageView alloc] initWithFrame:CGRectMake(10, 12.5, 15, 15)];
    commentIcon.image = [UIImage imageNamed:@"comment_icon.png"];
    [_inputBar addSubview:commentIcon];
    
    UILabel * commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 10, 40, 20)];
    commentLabel.text = @"评论";
    commentLabel.font = [UIFont systemFontOfSize:13];
    [_inputBar addSubview:commentLabel];
    
    _inputField = [[UITextField alloc] initWithFrame:CGRectMake(65, 5, frame.size.width- 75, 30)];
    _inputField.delegate = self;
    _inputField.borderStyle = UITextBorderStyleRoundedRect;
    _inputField.font = [UIFont systemFontOfSize:13];
    _inputField.returnKeyType = UIReturnKeySend;
    
    [_inputBar addSubview:_inputField];
    //_inputField.inputAccessoryView = _inputBar;
    
    [_inputBar.layer setBorderWidth:1.0]; //边框宽度
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 0.7, 0.7, 0.7, 1 });
    [_inputBar.layer setBorderColor:colorref];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeContentViewPoint:) name:UIKeyboardWillHideNotification object:nil];
    
   
    
}

- (void)configUI
{
    [self setNavgationTitle:@"评论"];
}

- (void)refreshData
{
    if (!_request) {
         _request = [[YXHttpRequest alloc] init];
    }
    NSString *  path = [NSString stringWithFormat:video_comment,(long)1, _countOfAPage,self.videoid];
    
    [_request afGetWithUrlString:path finished:^(id responseObj) {
        [_dataArray removeAllObjects];
        NSArray * data = responseObj[@"msg"][@"data"];
        [_dataArray addObjectsFromArray:[YXCommentModel getModelsFromArray:data]];
        [_tableView reloadData];
        [_refreshControl endRefreshing];
        
        _countOfAll = [responseObj[@"msg"][@"page"][@"total"] integerValue];
        _totalPage = [responseObj[@"msg"][@"page"][@"allpage"] integerValue];
        _currentPage = 1;
        if (_totalPage == _currentPage) {
            [self setloadControlTitle:@"已经加载全部数据"];
        }
    } failed:^(NSString *errorMsg) {
        
    }];
}


- (void)loadData
{
    
    if (_currentPage == _totalPage) {
        return;
    }
    
    if (!_request) {
        _request = [[YXHttpRequest alloc] init];
    }
    NSString *  path = [NSString stringWithFormat:video_comment,++_currentPage, _countOfAPage,self.videoid];
    
    [_request afGetWithUrlString:path finished:^(id responseObj) {
        NSArray * data = responseObj[@"msg"][@"data"];
        [_dataArray addObjectsFromArray:[YXCommentModel getModelsFromArray:data]];
        [_tableView reloadData];
        [_refreshControl endRefreshing];
        
        if (_totalPage == _currentPage) {
            [self setloadControlTitle:@"已经加载全部数据"];
        }
    } failed:^(NSString *errorMsg) {
        
    }];

}
#pragma mark -  tableview

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXCommentModel * model = _dataArray[indexPath.row];
    return model.cellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXCommentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YXCommentCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YXCommentCell" owner:self options:nil] lastObject];
    }
    YXCommentModel * model = _dataArray[indexPath.row];
    
    cell.commentTitleLabel.text = model.username;
    [cell.commentImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"doushangshang.com/%@", model.face]] placeholderImage:[UIImage imageNamed:@"photo_default"]];
    [cell.commentReplayButton addTarget:self action:@selector(replayBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    cell.commentReplayButton.tag = 100 + indexPath.row;
    cell.commentFloorLabel.text = [NSString stringWithFormat:@"%ld楼", _dataArray.count - indexPath.row];
    [cell setCommentDetail:model.content];

    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)replayBtnClicked:(UIButton *)btn
{
    YXCommentModel * model = _dataArray[btn.tag - 100];
    _replayString = [NSString stringWithFormat:@"回复@%@:", model.username];
    _inputField.placeholder = _replayString;
    [_inputField becomeFirstResponder];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_inputField resignFirstResponder];
    _inputField.placeholder = nil;
}

#pragma mark - 输入框
// 根据键盘状态，调整inputView的位置
- (void) changeContentViewPoint:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat keyBoardEndY = value.CGRectValue.origin.y ;  // 得到键盘弹出后的键盘视图所在y坐标

    NSNumber *duration = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSNumber *curve = [userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey];        // 添加移动动画，使视图跟随键盘移动
    [UIView animateWithDuration:duration.doubleValue animations:^{
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationCurve:[curve intValue]];
        _inputBar.center = CGPointMake(_inputBar.center.x, keyBoardEndY - 64 - _inputBar.bounds.size.height/2.0);   // keyBoardEndY的坐标是整个屏幕对应的高度，要减去
    }];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (!_request) {
        _request = [[YXHttpRequest alloc] init];
    }
    
    NSString * conent;
    if (textField.placeholder.length > 0) {
        conent = [NSString stringWithFormat:@"%@%@", textField.placeholder, textField.text];
    }else {
        conent = textField.text;
    }
    
    NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
    
    NSString * sesskey = [defaults objectForKey:@"sessionid"];
    
    if (sesskey == nil) {
        YXLoginPage * login = [[YXLoginPage alloc] init];
        [self.navigationController pushViewController:login animated:YES];
    } else {
        
        NSDictionary * parm = @{@"content":conent,
                                @"sesskey":sesskey,
                                @"videoid":self.videoid};
        
        [_request afPostWithUrlString:add_comment parm:parm finished:^(id responseObj) {
            NSLog(@"%@", responseObj);
            
            NSInteger code = [responseObj[@"code"] integerValue];
            
            if (code == 1) {
                [self refreshData];
                
            }else {
                 YXLoginPage * login = [[YXLoginPage alloc] init];
                [self.navigationController pushViewController:login animated:YES];
            }
            
        } failed:^(NSString *errorMsg) {
            
        }];
    }

    [textField resignFirstResponder];
    _inputField.placeholder = nil;
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_inputField resignFirstResponder];
    _inputField.placeholder = nil;
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
