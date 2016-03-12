//
//  UIImage+Extension.m
//  12-0QQ 聊天窗口
//
//  Created by Apple on 16/1/10.
//  Copyright © 2016年 Apple. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+(instancetype)resizeImageWithName:(NSString *)imageName{
    UIImage *resizeImg = [UIImage imageNamed:imageName];
    // 图片缩放
    resizeImg = [resizeImg stretchableImageWithLeftCapWidth:resizeImg.size.width / 2 topCapHeight:resizeImg.size.height /2];
    return resizeImg;
}

@end
