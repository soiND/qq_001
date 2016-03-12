//
//  ViewController.m
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/9.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "ViewController.h"
#import "Message.h"
#import "MessageCell.h"
#import "MessageFrame.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

// 数据模型
@property (nonatomic, strong) NSMutableArray *messageFrames;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

-(NSMutableArray *)messageFrames{
    if (!_messageFrames) {
        /*
//        // 1.加载模型数据
//        NSArray *messages = [Message messageList];
//        NSMutableArray *arrM = [NSMutableArray array];
//        // 2.创建 frame 模型
//        [messages enumerateObjectsUsingBlock:^(Message *obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            MessageFrame *frame = [[MessageFrame alloc] init];
//            frame.message = obj;
//            [arrM addObject:frame];
//        }];
//        _messageFrames = arrM;
        */
        _messageFrames = [MessageFrame messageFrameList];
    }
    return _messageFrames;
}

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.tableView.rowHeight = 200;

    // 去掉分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 不能选中
    self.tableView.allowsSelection = NO;
    // 背景色
    self.tableView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];

    // 订阅通知,添加一个订阅者
    // 监听键盘 frame 的变化
    // 不管是谁发布了UIKeyboardWillChangeFrameNotification这个通知,就会执行keboardWillChangeFrame这个操作
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(void) keboardWillChangeFrame:(NSNotification *)noti{

    // 键盘的动画时间
    CGFloat duration = [noti.userInfo[@"UIKeyboardAnimationDurationUserInfoKey"] floatValue];
    // 键盘消失/显示的时候,获取最终位置
    CGRect frame = [noti.userInfo[@"UIKeyboardFrameEndUserInfoKey"] CGRectValue];
    // 要移动的距离 = 键盘最终的 y 值 - view 自身的高度
    CGFloat offsetY = frame.origin.y - self.view.frame.size.height;
    [UIView animateWithDuration:duration animations:^{
        // 平移 view
        self.view.transform = CGAffineTransformMakeTranslation(0, offsetY);
    }];


//    NSLog(@"%@",noti.userInfo);
    /*
     弹出
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";键盘弹出所需的时间
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";键盘弹出时的最终位置
     UIKeyboardIsLocalUserInfoKey = 1;
     */

    /*
     消失
     UIKeyboardAnimationCurveUserInfoKey = 7;
     UIKeyboardAnimationDurationUserInfoKey = "0.25";键盘消失所需的时间
     UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
     UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 538}";
     UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 796}";
     UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
     UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";键盘消失时的最终位置
     UIKeyboardIsLocalUserInfoKey = 1;
     */
}

// 销毁的目的是防止给野指针发布通知
- (void)dealloc{
    // 销毁
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - 设置数据源方法
// 只有1组,默认

// 每组有多少行
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.messageFrames.count;
}

// 创建每一行的 cell
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    // 1.创建自定义的可重用的 cell
    MessageCell *cell = [MessageCell messageCellWithTableView: tableView];

    // 2.给cell的子控件赋值
    cell.messageFrame = self.messageFrames[indexPath.row];

    // 3.返回 cell
    return cell;
}

#pragma mark - 设置代理方法
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self.messageFrames[indexPath.row] rowHeight];
}

// 拖动界面的时候,隐藏键盘
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.view endEditing:YES];
}

#pragma mark - 文本框的代理方法
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSString *msg = textField.text;
    [self sendMessage:msg type:MessageTypeSelf];

    if ([msg isEqualToString:@"hi"]) {
        [self sendMessage:@"您好" type: MessageTypeOther];
    }else{
        [self sendMessage:@"叼你" type: MessageTypeOther];
    }

    // 清空
    textField.text = nil;

    return NO;
}

// 发送消息
-(void) sendMessage:(NSString *)msg type:(MessageType)type{
    Message *message = [[Message alloc] init];
    message.text = msg;
    message.type = type;
    // 获取当前时间
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"HH:mm";

    message.time = [formatter stringFromDate:date];

    // 上一个消息
    MessageFrame *last_messageFrame = [self.messageFrames lastObject];
    Message *last_message = last_messageFrame.message;
    if ([last_message.time isEqualToString:message.time]) {
        message.hiddenTime = YES;
    }else{
        message.hiddenTime = NO;
    }

    MessageFrame *add_messageFrame = [[MessageFrame alloc] init];
    add_messageFrame.message = message;

    // 添加到 messagesFrame 中
    [self.messageFrames addObject:add_messageFrame];

    // 插入到新的 cell 中
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.messageFrames.count - 1 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];

//    [self.tableView reloadData];

    // 滚动到 cell 的底部
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];
}


@end
