//
//  Message.h
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    MessageTypeSelf = 0,
    MessageTypeOther = 1
} MessageType;

@interface Message : NSObject

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) MessageType type;

/**
 *  是否隐藏时间(默认是NO,显示)
 */
@property (nonatomic, assign, getter=isHiddenTime) BOOL hiddenTime;

- (instancetype) initWithDict: (NSDictionary *)dict;
+ (instancetype) messageWithDict: (NSDictionary *)dict;

+ (NSArray *) messageList;


@end
