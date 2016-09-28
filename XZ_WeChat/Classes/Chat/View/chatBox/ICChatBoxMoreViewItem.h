//
//  ICChatBoxMoreViewItem.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/14.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICChatBoxMoreViewItem : UIView

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *imageName;


- (void)addTarget:(id)target action:(SEL)action
                   forControlEvents:(UIControlEvents)controlEvents;

/**
 *  创建一个ICChatBoxMoreViewItem
 *
 *  @param title     item的标题
 *  @param imageName item的图片
 *
 *  @return item
 */
+ (ICChatBoxMoreViewItem *)createChatBoxMoreItemWithTitle:(NSString *)title
                                                imageName:(NSString *)imageName;

@end
