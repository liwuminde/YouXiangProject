//
//  YXPlatformProductPage.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/29.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXPlatformProductPage.h"
#include "YXHttpRequest.h"
#include "UIImageView+WebCache.h"
#include "YXBasicReusableView.h"
#include "YXItemCatsCell.h"
#include "YXHotProductCell.h"
#include "YXCategoryModel.h"
#include "YXProductModel.h"
#include "YXProductDetailPage.h"
@interface YXPlatformProductPage () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    UICollectionView * _collectView;
    NSMutableArray * _dataArray;
    //YXHttpRequest * _request;
}
@end

@implementation YXPlatformProductPage

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
    //成员变量
    _dataArray = [NSMutableArray array];
    
    NSMutableArray * itemsArray = [NSMutableArray array];
    NSMutableArray * hotArray = [NSMutableArray array];
    [_dataArray addObject:itemsArray];
    [_dataArray addObject:hotArray];
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc] init];
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 64 - 35) collectionViewLayout:flowLayout];
    _collectView.delegate = self;
    _collectView.dataSource = self;
    _collectView.backgroundColor = [UIColor colorWithRed:0.92 green:0.92 blue:0.92 alpha:1];
    [self.view addSubview:_collectView];

    [_collectView registerNib:[UINib nibWithNibName:@"YXHotProductCell" bundle:nil] forCellWithReuseIdentifier:@"HotProductCell"];
    [_collectView registerNib:[UINib nibWithNibName:@"YXItemCatsCell" bundle:nil] forCellWithReuseIdentifier:@"YXItemCatsCell"];
 
    [_collectView registerClass:[YXBasicReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YXBasicReusableView"];
    [self loadHotProductData];
    [self loadItemcastData];
}

- (void)loadItemcastData
{
  
    YXHttpRequest * _request = [[YXHttpRequest alloc] init];
    
    
    [_request afGetWithUrlString:itemcats finished:^(id responseObj) {
        NSDictionary * catDict  = responseObj[@"msg"];
        
        NSMutableArray * resultArray = _dataArray[0];
        [resultArray addObjectsFromArray:[YXCategoryModel getModelsFromDict:catDict]];
        
        [_collectView reloadData];
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (void)loadHotProductData
{

     YXHttpRequest *  _request = [[YXHttpRequest alloc] init];
  
    
    [_request afGetWithUrlString:platformproduct finished:^(id responseObj) {
        NSDictionary * dataDict = responseObj[@"msg"][@"data"];
        NSMutableArray * resultAray = _dataArray[1];
        
        [resultAray addObjectsFromArray:[YXProductModel getModelsFromDict:dataDict]];
        
        [_collectView reloadData];
    } failed:^(NSString *errorMsg) {
        
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray * array = _dataArray[section];
    return array.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 2;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return CGSizeMake(90, 112);
    }else {
        return CGSizeMake(145, 182);
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return CGSizeZero;
    }else {
        return CGSizeMake(collectionView.frame.size.width, 20);
    }
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5,10 , 5, 10);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    YXBasicReusableView  * view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"YXBasicReusableView" forIndexPath:indexPath];
    
    if (indexPath.section == 1) {
        [view setLabelTitle:@"热门商品"];
    }
    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        YXItemCatsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"YXItemCatsCell" forIndexPath:indexPath];
        YXCategoryModel * model = _dataArray[0][indexPath.row];
        
        cell.itemCatsTitleLabel.text = model.name;
        return cell;
        
    }else {
        YXHotProductCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HotProductCell" forIndexPath:indexPath];
        
        YXProductModel * model = _dataArray[1][indexPath.row];
        
        [cell.hotProductImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://doushangshang.com/%@", model.goods_thumb]]];
        
        cell.hotProductNameLabel.text = model.goods_name;
        return cell;
    }
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1) {
        
        YXProductModel * model = _dataArray[indexPath.section][indexPath.row];
        
        YXProductDetailPage * detail = [[YXProductDetailPage alloc] init];
        detail.goodsId = model.goods_id;
        [self.navigationController  pushViewController:detail animated:YES];
        
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
