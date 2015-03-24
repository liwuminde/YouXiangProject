//
//  YXMessageModel.h
//  YouXiangProject
//
//  Created by qianfeng on 15/2/3.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXBaseObject.h"

@interface YXMessageModel : YXBaseObject

@property (nonatomic, copy) NSString * userid;
@property (nonatomic, copy) NSString * roomid;
@property (nonatomic, copy) NSString * type;
@property (nonatomic, copy) NSString * username;
@property (nonatomic, copy) NSString * face;
@property (nonatomic, copy) NSString * id;
@property (nonatomic, copy) NSString * msgid;
@property (nonatomic, copy) NSString * word;
@property (nonatomic, copy) NSString * addtime;

@end
