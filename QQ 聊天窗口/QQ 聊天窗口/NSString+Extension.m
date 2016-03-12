//
//  NSString+Extension.m
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

-(CGSize)sizeWithMaxSize:(CGSize)maxSize andFontSize:(CGFloat)fontSize{
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
}


@end
