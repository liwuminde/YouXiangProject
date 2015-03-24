//
//  YXHttpRequest.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//
#import "YXHttpRequest.h"
#import "AFNetworking.h"

@implementation YXHttpRequest
{
    DownloadFinishedBlock _finishedBlock;
    DownloadFailedBlock _failedBlock;
    
}

- (void)afGetWithUrlString:(NSString *)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock
{
    if (_finishedBlock != finishedBlock) {
        _finishedBlock = nil;
        _finishedBlock = finishedBlock;
    }
    
    if (_failedBlock != failedBlock) {
        _failedBlock = nil;
        _failedBlock =  failedBlock;
    }
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    manger.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"text/html", nil];
    //bolck赋值必weicopy
    [manger GET:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _finishedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failedBlock(error.localizedDescription);
    }];

}

- (void)afPostWithUrlString:(NSString *)urlString parm:(NSDictionary * )dic finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock
{
    if (_finishedBlock != finishedBlock) {
        _finishedBlock = nil;
        _finishedBlock = finishedBlock;
    }
    
    if (_failedBlock != failedBlock) {
        _failedBlock = nil;
        _failedBlock =  failedBlock;
    }
    
    //post请求
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    
    manger.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"text/html", nil];
    
    [manger POST:urlString parameters:dic success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _finishedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failedBlock(error.localizedDescription);
    }];
}

- (void) afPostDataWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic imageData:(NSData *)imageData imageKey:(NSString * )key finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock
{
    if (_finishedBlock != finishedBlock) {
        _finishedBlock = nil;
        _finishedBlock = finishedBlock;
    }
    
    if (_failedBlock != failedBlock) {
        _failedBlock = nil;
        _failedBlock =  failedBlock;
    }
    
    AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
    
    manger.responseSerializer.acceptableContentTypes  = [NSSet setWithObjects:@"text/html", nil];
    
    [manger POST:urlString parameters:dic constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //用formData对象实现图片的上传
        //第一个block用于设置上传的文件
        [formData appendPartWithFileData:imageData name:key fileName:@"test.jpg" mimeType:@"image/jpg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _finishedBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        _failedBlock(error.localizedDescription);
    }];
}


@end
