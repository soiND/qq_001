//
//  MessageFrame.m
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MessageFrame.h"
#import "Message.h"
#import "NSString+Extension.h"

@implementation MessageFrame

+(NSMutableArray *) messageFrameList{
    // 1.加载模型数据
    NSArray *messages = [Message messageList];
    NSMutableArray *arrM = [NSMutableArray array];
    // 2.创建 frame 模型
    [messages enumerateObjectsUsingBlock:^(Message *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        MessageFrame *frame = [[self alloc] init];
        frame.message = obj;
        [arrM addObject:frame];
    }];
    return arrM;
}

// 重写 setter 方法
-(void)setMessage:(Message *)message{
    _message = message;

    // 获取屏幕的宽度
    UIScreen *screen = [UIScreen mainScreen];
    CGFloat screenWidth = screen.bounds.size.width;

    CGFloat margin = 10;

    // 计算 frame

    // 时间
    CGFloat timeW = screenWidth;
    CGFloat timeH = 40;
    CGFloat timeX = 0;
    CGFloat timeY = 0;
    if (!message.isHiddenTime) {
        _timeFrame = CGRectMake(timeX, timeY, timeW, timeH);
    }else{
        _timeFrame = CGRectZero;
    }

    // 头像
    CGFloat iconW = 50;
    CGFloat iconH = 50;
//    CGFloat iconY = timeH;
    CGFloat iconY = CGRectGetMaxY(_timeFrame);
    CGFloat iconX;
    if (message.type == MessageTypeSelf) {
        iconX = screenWidth - iconW - margin;
    }else{
        iconX = margin;
    }
    _iconFrame = CGRectMake(iconX, iconY, iconW, iconH);

    // 内容
    // 文字的大小
//    CGSize textSize = [self sizeWithText:message.text maxSize:CGSizeMake(250, MAXFLOAT) fontSize:TextFontSize];
    CGSize textSize = [message.text sizeWithMaxSize:CGSizeMake(250, MAXFLOAT) andFontSize:TextFontSize];
    // 按钮的大小
    CGSize buttonSize = CGSizeMake(textSize.width + 20 * 2, textSize.height + 20 * 2);
//    CGFloat textW = textSize.width;
//    CGFloat textH = textSize.height;
    CGFloat textW = buttonSize.width;
    CGFloat textH = buttonSize.height;
    CGFloat textY = iconY;
    CGFloat textX;
    if (message.type == MessageTypeSelf) {
        textX = iconX - margin - textW;
    }else{
        textX = CGRectGetMaxX(_iconFrame) + margin;
    }
    _textFrame = CGRectMake(textX, textY, textW, textH);

    // 计算行高
    CGFloat iconMaxY = CGRectGetMaxY(_iconFrame);
    CGFloat textMaxY = CGRectGetMaxY(_textFrame);
    _rowHeight = MAX(iconMaxY, textMaxY) + margin;
}

// 文字的大小
//- (CGSize)sizeWithText: (NSString *)text maxSize: (CGSize)maxSize fontSize:(CGFloat)fontSize{
//    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]} context:nil].size;
//}

@end
