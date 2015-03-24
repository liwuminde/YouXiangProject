//
//  TCSliderView.m
//  TCSliderView
//
//  Created by qianfeng on 15/1/23.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "TCSliderView.h"
#import "UIImageView+WebCache.h"
@interface TCSliderView ()<UIScrollViewDelegate>
{
    NSTimer * _timer;
    UIScrollView *  _scrollView;
    NSMutableArray * _imageViewArray;
    //NSInteger _currentImageViewIndex;
    NSInteger _presentedIndex;
    
    CGFloat  _inter;
}
@end


@implementation TCSliderView
{
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _timeInterval = 1.0;
        _isSlid = NO;
        _imageViewArray = [NSMutableArray array];
        _presentedIndex = 0;
        [self configUI];
    }
    return self;
}

- (void)configUI
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.backgroundColor = [UIColor blackColor];
    [self addSubview:_scrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 30  , self.frame.size.width ,  30)];
    _pageControl.currentPage = 0;
    _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
    [self addSubview:_pageControl];
    
    [_pageControl setValue:[UIImage imageNamed:@"pagecontrol_selected.png"] forKey:@"currentPageImage"];
    [_pageControl setValue:[UIImage imageNamed:@"pagecontrol_normal.png"] forKey:@"pageImage"];
}


#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    if (scrollView.contentOffset.x < 0) {
        _scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * _imageNameArray.count - 1 , 0);
       
    }else if(scrollView.contentOffset.x > scrollView.contentSize.width - scrollView.frame.size.width){
       _scrollView.contentOffset = CGPointMake(scrollView.frame.size.width * 1 , 0);
    }
    
    _inter = scrollView.contentOffset.x;
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGRect frame = scrollView.bounds;
    _presentedIndex = scrollView.contentOffset.x / frame.size.width;
  
    if (_presentedIndex == 0) {
        _scrollView.contentOffset = CGPointMake(frame.size.width * (_imageNameArray.count) , 0);
    }else if(_presentedIndex == _imageNameArray.count + 1) {
        _scrollView.contentOffset = CGPointMake(frame.size.width , 0);
    }
    
    _presentedIndex = scrollView.contentOffset.x / frame.size.width - 1;
    _pageControl.currentPage = _presentedIndex;
    if ([self.delegate respondsToSelector:@selector(sliderView:didPresentedWithIndex:)]) {
        [self.delegate sliderView:self didPresentedWithIndex:_presentedIndex];
    }
}

- (void)setIsSlid:(BOOL)isSlid
{
    if (isSlid) {
        _isSlid = YES;
        
        if (_timer == nil) {
            _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(sliderFunction:) userInfo:nil repeats:YES];
        }
        [_timer setFireDate:[NSDate distantPast]];
        
    }else {
        _isSlid = NO;
        
        if (_timer) {
            [_timer setFireDate:[NSDate distantFuture]];
        }
    }
}

- (void) setTimeInterval:(CGFloat)timeInterval
{
    _timeInterval = timeInterval;
    
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
        _timer = [NSTimer scheduledTimerWithTimeInterval:_timeInterval target:self selector:@selector(sliderFunction:) userInfo:nil repeats:YES];
        
        if (_isSlid) {
            [_timer setFireDate:[NSDate distantPast]];
        }
    }
}

- (void)sliderFunction:(id) userInfo
{
   // NSLog(@"掉 掉");
}

- (void)setUrlStringArray:(NSArray *)urlStringArray
{
    if (urlStringArray.count == 0) {
        return;
    }
    
    if (urlStringArray != _urlStringArray) {
        _urlStringArray =  urlStringArray;
    }
    
    [self removeImageViews];
    
    CGRect frame = self.bounds;
    for (NSInteger i = 0; i < _urlStringArray.count + 2; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
        NSString * path = nil;
        
        if (i == 0) {
            path = [_urlStringArray lastObject];
        }else if (i == urlStringArray.count + 1){
            path = [_urlStringArray firstObject];
        }else {
            path = _urlStringArray[i - 1];
        }
        
        [imageView setImageWithURL:[NSURL URLWithString:path]];
        
        [_imageViewArray addObject:imageView];
        
        [_scrollView addSubview:imageView];
        
    }
    
    _scrollView.contentSize =  CGSizeMake(frame.size.width * (_urlStringArray.count + 2), frame.size.height);
    _scrollView.contentOffset = CGPointMake(frame.size.width , 0);
     _pageControl.numberOfPages =  _urlStringArray.count;
}

- (void)setImageNameArray:(NSArray *)imageNameArray
{
    if (imageNameArray.count == 0) {
        return;
    }
    
    if (_imageNameArray != imageNameArray) {
        _imageNameArray =  imageNameArray;
    }
    
    [self removeImageViews];
    
    CGRect frame = self.bounds;
    for (NSInteger i = 0; i < _imageNameArray.count + 2; i++) {
        UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(frame.size.width * i, 0, frame.size.width, frame.size.height)];
        NSString * path = nil;
        
        if (i == 0) {
            path = [_imageNameArray lastObject];
        }else if (i == _imageNameArray.count + 1){
            path = [_imageNameArray firstObject];
        }else {
            path = _imageNameArray[i - 1];
        }
        
        imageView.image = [UIImage imageNamed:path];
        
        [_imageViewArray addObject:imageView];
        
        [_scrollView addSubview:imageView];
        
    }
    
    _scrollView.contentSize =  CGSizeMake(frame.size.width * (_imageNameArray.count + 2), frame.size.height);
    _scrollView.contentOffset = CGPointMake(frame.size.width , 0);
    
    _pageControl.numberOfPages =  _imageNameArray.count;
    _pageControl.currentPage = 0;
}

- (void)removeImageViews
{
    for (UIView * view in _imageViewArray) {
        [view removeFromSuperview];
    }
    
    [_imageViewArray removeAllObjects];
}

- (void)dealloc
{
    [_timer invalidate];
    _timer = nil;
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
