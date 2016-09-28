//
//  ICDocumentCell.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/7/22.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICBaseMessageCell.h"

@protocol ICDocumentCellDelegate <NSObject>

- (void)selectBtnClicked:(id)sender;

@end

@interface ICDocumentCell : ICBaseMessageCell


@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *filePath;

@property (nonatomic, weak) id<ICDocumentCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, weak) UIButton *selectBtn;



@end
