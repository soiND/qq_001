//
//  NSString+Extension.h
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

//#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)

// 获取字段大小
- (CGSize) sizeWithMaxSize: (CGSize)maxSize andFontSize:(CGFloat)fontSize;

@end
