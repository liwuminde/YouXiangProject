//
//  YXAddressSelectedView.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/31.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXAddressSelectedView.h"
#import "YXHttpRequest.h"
#import "YXReginModel.h"
#import "UIView+Border.h"
#import "YXReginCell.h"
#import "TCAlertWindow.h"
#import "YXUserDefaultsHelper.h"
@interface YXAddressSelectedView () <UITableViewDataSource, UITableViewDelegate>
{
    id _target;
    SEL _action;
}
@end

@implementation YXAddressSelectedView
{
    UITableView * _tableView;
    NSMutableArray * _dataArray;
    
    UIButton * _nextButtonBig;
    UIButton * _preButton;
    UIButton * _nextButton;
    NSInteger _lastSelected;
    NSInteger _step;
    
    NSArray * _proviceArray;
    NSArray * _cityArray;
    
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _dataArray = [NSMutableArray array];
        [self configUI];
    }
    return self;
}

- (void) configUI
{
    self.frame = CGRectMake(0, 0, 260, 200);
    CGRect frame = self.bounds;
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0,frame.size.width, frame.size.height - 41)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //_tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self addSubview:_tableView];
    
    UILabel * lineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 40, frame.size.width, 1)];
    lineLabel.backgroundColor = [UIColor colorWithRed:0.85 green:0.85 blue:0.85 alpha:1];
    [self addSubview:lineLabel];
    
    _nextButtonBig = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButtonBig.frame = CGRectMake(10, frame.size.height - 35, frame.size.width - 20, 30);
    [_nextButtonBig setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButtonBig setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextButtonBig.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.41 alpha:1];
    [_nextButtonBig setBorderRadius:5];
    _nextButtonBig.titleLabel.font = [UIFont systemFontOfSize:15];
    [_nextButtonBig addTarget:self action:@selector(nextBtnBigClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButtonBig];
    
    _nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _nextButton.frame = CGRectMake(frame.size.width/2 + 5, frame.size.height - 35, frame.size.width/2 - 15, 30);
    [_nextButton setTitle:@"下一步" forState:UIControlStateNormal];
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _nextButton.backgroundColor = [UIColor colorWithRed:1 green:0.41 blue:0.41 alpha:1];
    _nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_nextButton setBorderRadius:5];
    [_nextButton addTarget:self action:@selector(nextBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_nextButton];
    
    _preButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _preButton.frame = CGRectMake(10, frame.size.height - 35, frame.size.width/2 - 15, 30);
    [_preButton setTitle:@"上一步" forState:UIControlStateNormal];
    [_preButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    _preButton.backgroundColor = [UIColor whiteColor];
    [_preButton setBorderRadius:5];
    _preButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [_preButton setBorderColor:[UIColor blackColor] width:1];
    [_preButton addTarget:self action:@selector(preBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_preButton];
    
    _nextButtonBig.hidden = NO;
    _preButton.hidden = YES;
    _nextButton.hidden = YES;
    
    _step = 1;
    [self refreshDataWithType:@"1" parent:@"1"];
}

- (void)nextBtnBigClicked
{
    _step = 2;
    if (self.province) {
        _lastSelected = 0;
        [self refreshDataWithType:@"2" parent:self.province.region_id];
    }
}
     
- (void)nextBtnClicked
{
    if (_step == 2) {
        _lastSelected = 0;
        [self refreshDataWithType:@"3" parent:self.city.region_id];
    }else if(_step == 3){
        if (_alertWindow) {
            
            [YXUserDefaultsHelper saveDefaultAddress:@[self.province, self.city, self.regins]];
            
            if ([_target respondsToSelector:_action]) {
                [_target performSelector:_action withObject:[self getAddressString]];
            }
            
            TCAlertWindow * alert = (TCAlertWindow *)_alertWindow;
            [alert closeWindow];
        }
        
    }else{
        return;
    }
    
    _step++;
}

- (void)preBtnClicked
{
    if (_step == 3) {
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:_cityArray];
    }else if(_step ==  2){
        [_dataArray removeAllObjects];
        [_dataArray addObjectsFromArray:_proviceArray];
    }else {
        return;
    }
    
    _step--;
    
    NSIndexPath * indexPath;
    if (_step == 1) {
        indexPath = [NSIndexPath indexPathForRow:self.province.tag inSection:0];
        _lastSelected = self.province.tag;
    }else if (_step == 2){
        indexPath = [NSIndexPath indexPathForRow:self.city.tag inSection:0];
        _lastSelected = self.city.tag;
    }else {
        return;
    }
    
    [_tableView reloadData];
    [self setStepState];
    
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

- (void)refreshDataWithType:(NSString *)type parent:(NSString *)parent
{
    NSString * path ;
    
    if (parent) {
        path = [NSString stringWithFormat:@"%@%@&parent=%@",regin,type,parent];
    }else {
        path = [NSString stringWithFormat:@"%@%@",regin,type];
    }
    
    YXHttpRequest * _request = [[YXHttpRequest alloc] init];
    [_request afGetWithUrlString:path finished:^(id responseObj) {
        
        NSInteger code = [responseObj[@"code"] integerValue];
        if (code == 1) {
            
            if (_step == 2) {
                _proviceArray = [NSArray arrayWithArray:_dataArray];
            }else if(_step == 3){
                _cityArray = [NSArray arrayWithArray:_dataArray];
            }
            
            [_dataArray removeAllObjects];
            NSArray * dataArray = responseObj[@"msg"];
            [_dataArray addObjectsFromArray:[YXReginModel getModelsFromArray:dataArray]];
            
            [_tableView reloadData];
            [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            [self setStepState];
        }
        
    } failed:^(NSString *errorMsg) {
        
    }];
}


- (void)setStepState
{
    switch (_step) {
        case 1:
        {
            _nextButtonBig.hidden = NO;
            _preButton.hidden = YES;
            _nextButton.hidden = YES;
        }
            break;
        case 2:
        {
            _nextButtonBig.hidden = YES;
            _preButton.hidden = NO;
            _nextButton.hidden = NO;
        }
            break;
        case 3:
        {
            _nextButtonBig.hidden = YES;
            _preButton.hidden = NO;
            _nextButton.hidden = NO;
        }
            break;
            
        default:
        {
            _nextButtonBig.hidden = YES;
            _preButton.hidden = NO;
            _nextButton.hidden = NO;

        }
            break;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXReginCell * cell = [tableView dequeueReusableCellWithIdentifier:@"YXReginCell"];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"YXReginCell" owner:self options:nil] lastObject];
        cell.reginCheckbox.userInteractionEnabled = NO;
    }
    
    YXReginModel * model = _dataArray[indexPath.row];
    
    cell.reginNameLabel.text =  model.region_name;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_lastSelected == indexPath.row) {
        cell.reginCheckbox.isChecked = YES;
        
        if (_step == 1) {
            self.province = model;
            self.province.tag = indexPath.row;
        }else if(_step == 2) {
            self.city = model;
            self.city.tag = indexPath.row;
            
        }else if(_step == 3){
            self.regins = model;
            self.regins.tag = indexPath.row;
            
        }

    }else {
        cell.reginCheckbox.isChecked = NO;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 37.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YXReginCell * cell = (YXReginCell *)[_tableView cellForRowAtIndexPath:indexPath];
    cell.reginCheckbox.isChecked = YES;
    _lastSelected = indexPath.row;
    [_tableView reloadData];
    YXReginModel * model = _dataArray[indexPath.row];

    if (_step == 1) {
        self.province = model;
        self.province.tag = indexPath.row;
    }else if(_step == 2) {
        self.city = model;
        self.city.tag = indexPath.row;

    }else if(_step == 3){
        self.regins = model;
        self.regins.tag = indexPath.row;

    }
    
    NSLog(@"%@", model.region_name);
}

- (NSString *)getAddressString
{
    NSMutableString * result = [NSMutableString string];
    
    
    if (self.province) {
        [result appendFormat:@"中国%@省", self.province.region_name];
    }
    
    if (self.city) {
        [result appendFormat:@"%@市", self.city.region_name];
    }
    
    if (self.regins) {
        [result appendFormat:@"%@", self.regins.region_name];
    }
    
    return result;
}

- (void) addTaget:(id)target action:(SEL)action
{
    _target = target;
    _action = action;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
