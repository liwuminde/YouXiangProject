//
//  DEFINE.h
//  YouXiangProject
//
//  Created by qianfeng on 15/1/26.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#ifndef YouXiangProject_DEFINE_h
#define YouXiangProject_DEFINE_h


//14 获取视频评论
#define video_comment @"http://open.doushangshang.com/video.php?ac=video_comment&page=%ld&size=%ld&videoid=%@"

//15 发表视频评论:
#define add_comment @"http://open.doushangshang.com/video.php?ac=add_comment"


//核心产品
#define core_product @"http://open.doushangshang.com/category.php?id=1&brand=0&page=1&size=20"

#define product_detail @"http://open.doushangshang.com/goods.php?id=%@"

//平台
#define itemcats @"http://open.doushangshang.com/itemcats.php?id=3"

#define platformproduct @"http://open.doushangshang.com/category.php?id=2&brand=0&page=1&size=20"

//添加到购物车
#define addtocart @"http://open.doushangshang.com/order.php?ac=addtocart"

//获取购物车信息
#define getcart @"http://open.doushangshang.com/order.php?ac=getcart&cartsesskey=%@"

//获取地区
#define regin @"http://open.doushangshang.com/region.php?type="

//提交订单
#define kSubmitOrder @"http://open.doushangshang.com/order.php?ac=addorder"

//现场
#define kRoomList @"http://open.doushangshang.com/scene.php?ac=get_room_list&page=%ld&size=%ld"

#define kCreateRoom @"http://open.doushangshang.com/scene.php?ac=add_room"

#define kRoomDetail @"http://open.doushangshang.com/scene.php?ac=get_msg"



#endif
