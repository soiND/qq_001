//
//  MessageCell.m
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "MessageCell.h"
#import "MessageFrame.h"
#import "Message.h"
#import "UIImage+Extension.h"

@interface MessageCell()

// 时间
@property (nonatomic ,weak) UILabel *timeView;
// 头像
@property (nonatomic, weak) UIImageView *iconView;
// 聊天内容
@property (nonatomic, weak) UIButton *textView;

@end

@implementation MessageCell

// 1.创建自定义可重用的 cell
+(instancetype)messageCellWithTableView:(UITableView *)tableView{
    static NSString *reuseId = @"msg";
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (!cell) {
        cell = [[MessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseId];
    }
    return cell;
}

// 2.创建子控件
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        // 设置 cell 为透明
        self.backgroundColor = [UIColor clearColor];

        // 时间
        UILabel *timeView = [[UILabel alloc] init];
        [self.contentView addSubview:timeView];
        self.timeView = timeView;
        //
        timeView.textAlignment = NSTextAlignmentCenter;

        // 头像(先有头像,再有内容)
        UIImageView *iconView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconView];
        self.iconView = iconView;
        // 设置圆角
        iconView.layer.cornerRadius = 25;
        iconView.layer.masksToBounds = YES;

        // 聊天内容
        UIButton *textView = [[UIButton alloc] init];
        [self.contentView addSubview:textView];
        self.textView = textView;
        // 设置字体大小
        textView.titleLabel.font = [UIFont systemFontOfSize:TextFontSize];
        // 设置换行
        textView.titleLabel.numberOfLines = 0;
        // 设置字体颜色
        [textView setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        // 设置按钮中内容的边距
        textView.contentEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);

//        textView.backgroundColor = [UIColor redColor];

    }
    return self;
}

// 3.重写数据模型的 setter 方法
-(void)setMessageFrame:(MessageFrame *)messageFrame{

    _messageFrame = messageFrame;

    // 给子控件赋值
    Message *message = messageFrame.message;

    self.timeView.text = message.time;

    NSString *nameStr = message.type == 0 ? @"me" : @"other";
    self.iconView.image = [UIImage imageNamed:nameStr];

    [self.textView setTitle:message.text forState:UIControlStateNormal];

    // 设置消息的背景图片
    NSString *nor = nil;
    NSString *press = nil;
    if (message.type == MessageTypeSelf) {
        nor = @"chat_send_nor";
        press = @"chat_send_press_pic";
        /*
//        UIImage *bgImgNor = [UIImage imageNamed:@"chat_send_nor"];
//        UIImage *bgImgPress = [UIImage imageNamed:@"chat_send_press_pic"];
//
//        // 图片缩放
//        bgImgNor = [bgImgNor stretchableImageWithLeftCapWidth:bgImgNor.size.width / 2 topCapHeight:bgImgNor.size.height /2];
//        bgImgPress = [bgImgPress stretchableImageWithLeftCapWidth:bgImgPress.size.width /2 topCapHeight:bgImgPress.size.height /2];
//
//        [self.textView setBackgroundImage:bgImgNor forState:UIControlStateNormal];
//        [self.textView setBackgroundImage:bgImgPress forState:UIControlStateHighlighted];
         */
    }else{
        nor = @"chat_recive_nor";
        press = @"chat_recive_press_pic";

        /*

//        UIImage *bgImgNor = [UIImage imageNamed:@"chat_recive_nor"];
//        UIImage *bgImgPress = [UIImage imageNamed:@"chat_recive_press_pic"];
//
//        // 图片缩放
//        bgImgNor = [bgImgNor stretchableImageWithLeftCapWidth:bgImgNor.size.width / 2 topCapHeight:bgImgNor.size.height /2];
//        bgImgPress = [bgImgPress stretchableImageWithLeftCapWidth:bgImgPress.size.width /2 topCapHeight:bgImgPress.size.height /2];
//
//        [self.textView setBackgroundImage: bgImgNor forState:UIControlStateNormal];
//        [self.textView setBackgroundImage:bgImgPress forState:UIControlStateHighlighted];
         */
    }
//    UIImage *bgImgNor = [UIImage imageNamed:nor];
//    UIImage *bgImgPress = [UIImage imageNamed:press];

    // 图片缩放
//    bgImgNor = [bgImgNor stretchableImageWithLeftCapWidth:bgImgNor.size.width / 2 topCapHeight:bgImgNor.size.height /2];
//    bgImgPress = [bgImgPress stretchableImageWithLeftCapWidth:bgImgPress.size.width /2 topCapHeight:bgImgPress.size.height /2];

    UIImage *bgImgNor = [UIImage resizeImageWithName:nor];
    UIImage *bgImgPress = [UIImage resizeImageWithName:press];

    [self.textView setBackgroundImage:bgImgNor forState:UIControlStateNormal];
    [self.textView setBackgroundImage:bgImgPress forState:UIControlStateHighlighted];

    // 设置子控件的 frame
    self.timeView.frame = messageFrame.timeFrame;
    self.iconView.frame = messageFrame.iconFrame;
    self.textView.frame = messageFrame.textFrame;

//    if (!message.isHiddenTime) {
//        self.timeView.frame = messageFrame.timeFrame;
//    }else{
//        self.timeView.frame = CGRectZero;// cell的重用
//    }
}

@end
