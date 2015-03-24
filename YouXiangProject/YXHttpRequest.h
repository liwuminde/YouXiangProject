//
//  YXHttpRequest.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownloadFinishedBlock) (id responseObj);
typedef void(^DownloadFailedBlock)(NSString * errorMsg);

@interface YXHttpRequest : NSObject


- (void)afGetWithUrlString:(NSString *)urlString finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock;


- (void)afPostWithUrlString:(NSString *)urlString parm:(NSDictionary * )dic finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock;

- (void) afPostDataWithUrlString:(NSString *)urlString parms:(NSDictionary *)dic imageData:(NSData *)imageData imageKey:(NSString * )key finished:(DownloadFinishedBlock)finishedBlock failed:(DownloadFailedBlock)failedBlock;


@end
