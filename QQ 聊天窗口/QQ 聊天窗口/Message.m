//
//  Message.m
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "Message.h"

@implementation Message

-(instancetype)initWithDict:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return  self;
}

+(instancetype)messageWithDict:(NSDictionary *)dict{
    return [[self alloc] initWithDict:dict];
}

+(NSArray *)messageList{
    // 加载 plist
    NSString *path = [[NSBundle mainBundle] pathForResource:@"messages" ofType:@"plist"];
    NSArray *dictArr = [NSArray arrayWithContentsOfFile:path];

    // 字典转模型
    NSMutableArray *arrM = [NSMutableArray array];
    // 上一个 message
    __block Message *preMessage = nil;
    [dictArr enumerateObjectsUsingBlock:^(NSDictionary *dict, NSUInteger idx, BOOL * _Nonnull stop) {

        // 当前的 message
        Message *message = [Message messageWithDict:dict];

        if ([message.time isEqualToString:preMessage.time]) {
            message.hiddenTime = YES;// 时间相等,隐藏
        }

        [arrM addObject:message];

        // 设置上一个 message
        preMessage = message;
    }];

    return arrM;
}

@end
