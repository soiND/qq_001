//
//  MessageCell.h
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class Message;
@class MessageFrame;

@interface MessageCell : UITableViewCell

// 模型数据
//@property (nonatomic, strong) Message *message;
@property (nonatomic, strong) MessageFrame *messageFrame;


// 创建自定义可重用的 cell
+ (instancetype) messageCellWithTableView: (UITableView *)tableView;

@end
