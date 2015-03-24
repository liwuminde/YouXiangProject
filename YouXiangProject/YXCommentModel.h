//  YXCommentModel.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/28.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXBaseObject.h"

@interface YXCommentModel : YXBaseObject

@property (nonatomic, copy) NSString * addtime;
@property (nonatomic, copy) NSString * commentid;
@property (nonatomic, copy) NSString * content;
@property (nonatomic, copy) NSString * status;
@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * userinfo;
@property (nonatomic, copy) NSString * videoid;

@property (nonatomic, copy) NSString * face;
@property (nonatomic, copy) NSString * username;

@property (nonatomic, assign) CGFloat  cellHeight;

@end
