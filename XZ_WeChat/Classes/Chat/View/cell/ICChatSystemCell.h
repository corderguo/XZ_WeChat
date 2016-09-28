//
//  ICChatSystemCell.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/6/7.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICChatSystemCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
                       reusableId:(NSString *)ID;

@property (nonatomic, strong) ICMessageFrame *messageF;

@end
