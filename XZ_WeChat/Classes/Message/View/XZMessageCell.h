//
//  XZMessageCell.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#import "XZBaseTableViewCell.h"

@interface XZMessageCell : XZBaseTableViewCell

@property (nonatomic, strong) XZGroup * group;

@property (nonatomic, weak) UIButton *unreadLabel;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
