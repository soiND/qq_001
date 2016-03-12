//
//  MessageFrame.h
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import <CoreGraphics/CoreGraphics.h>

#define TextFontSize 15

#import <UIKit/UIKit.h>
@class Message;

@interface MessageFrame : NSObject

@property (nonatomic ,assign, readonly) CGRect timeFrame;
@property (nonatomic, assign, readonly) CGRect iconFrame;
@property (nonatomic, assign, readonly) CGRect textFrame;

/**
 *  高度
 */
@property (nonatomic, assign, readonly) CGFloat rowHeight;

/**
 *  模型数据
 */
@property (nonatomic, strong) Message *message;

// 获取frame 列表
+ (NSMutableArray *)messageFrameList;

@end
