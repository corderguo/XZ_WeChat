//
//  ICChatMessageSyeCell.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/29.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICMessageFrame;

@interface ICChatMessageSyeCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;

@property (nonatomic, strong) ICMessageFrame *messageF;

@end
