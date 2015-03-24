//
//  YXCartGoodsModel.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/30.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXBaseObject.h"

@interface YXCartGoodsModel : YXBaseObject

@property (nonatomic, copy) NSString * can_handsel;
@property (nonatomic, copy) NSString * extension_code;
@property (nonatomic, copy) NSString * goods_attr;
@property (nonatomic, copy) NSString * goods_attr_id;
@property (nonatomic, copy) NSString * goods_id;
@property (nonatomic, copy) NSString * goods_name;
@property (nonatomic, copy) NSString * goods_number;
@property (nonatomic, copy) NSString * goods_price;
@property (nonatomic, copy) NSString * goods_sn;
@property (nonatomic, copy) NSString * goods_thumb;
@property (nonatomic, copy) NSString * is_gift;
@property (nonatomic, copy) NSString * is_real;
@property (nonatomic, copy) NSString * is_shipping;
@property (nonatomic, copy) NSString * market_price;
@property (nonatomic, copy) NSString * parent_id;
@property (nonatomic, copy) NSString * pid;
@property (nonatomic, copy) NSString * product_id;
@property (nonatomic, copy) NSString * rec_id;
@property (nonatomic, copy) NSString * rec_type;
@property (nonatomic, copy) NSString * session_id;
@property (nonatomic, copy) NSString * subtotal;
@property (nonatomic, copy) NSString * user_id;

@property (nonatomic, assign) BOOL isChecked;

@end
