//
//  YXCommentModel.m
//  YouXiangProject
//
//  Created by qianfeng on 15/1/28.
//  Copyright (c) 2015年 ThinkCode. All rights reserved.
//

#import "YXCommentModel.h"

@implementation YXCommentModel


+ (NSArray *)getModelsFromArray:(NSArray *)array
{
    NSMutableArray * result = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        YXCommentModel * model =  [[YXCommentModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dict];
        
        for (NSString * key in dict) {
            id obj = dict[key];
            if ([obj isKindOfClass:[NSNumber class]]) {
                [model setValue:[obj stringValue] forKey:key];
            }
        }
        
        NSDictionary * useinfo = dict[@"userinfo"];
        model.face = useinfo[@"face"];
        model.username = useinfo[@"username"];
        
        [result addObject:model];
    }
    
    return result;
}

- (CGFloat)cellHeight
{
    NSDictionary * dict = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
    
    CGSize size = [_content boundingRectWithSize:CGSizeMake(230, 999) options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading  attributes:dict context:nil].size;
    
    CGFloat height = 23 + size.height;
    
    if (height > 65) {
        height = 23 + size.height + 10;
        return height;
    }
    
    return 65;
}

@end
