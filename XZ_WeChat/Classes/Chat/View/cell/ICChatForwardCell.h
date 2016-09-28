//
//  ICChatForwardCell.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/7/15.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICBaseMessageCell.h"
@class ICGroup;

@interface ICChatForwardCell : ICBaseMessageCell

@property (nonatomic, strong) ICGroup *group;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
