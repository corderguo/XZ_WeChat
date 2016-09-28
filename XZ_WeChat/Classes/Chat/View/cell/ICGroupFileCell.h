//
//  ICGroupFileCell.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/8/16.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICBaseMessageCell.h"

@class ICGroupFileCell;

@protocol GroupFileDelegate <NSObject>

- (void)isFileExisted:(ICGroupFileCell *)cell
            isExisted:(BOOL)isExisted
              fileKey:(NSString *)fileKey
             fileName:(NSString *)fileName;

@end

@interface ICGroupFileCell : ICBaseMessageCell


+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) ICMessage *message;

@property (nonatomic, weak) id <GroupFileDelegate>delegate;

@property (nonatomic, weak) UIProgressView *progressView;
@property (nonatomic, weak) UIButton *seeBtn;


@end
