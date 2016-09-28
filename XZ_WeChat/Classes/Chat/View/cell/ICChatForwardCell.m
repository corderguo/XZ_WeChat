//
//  ICChatForwardCell.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/7/15.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICChatForwardCell.h"

#define headImageHeight 34
@interface ICChatForwardCell ()

@property (nonatomic, weak) UIImageView *headImageView;

@property (nonatomic, weak) UILabel *titleLabel;

@end

@implementation ICChatForwardCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftFreeSpace = 70;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"forwarCell";
    ICChatForwardCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ICChatForwardCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

- (void)setGroup:(XZGroup *)group
{
    _group = group;
    
    self.titleLabel.text = group.gName;
//    NSURL *imgURL = [NSURL URLWithString:MINIMAGEURL(group.photoId)];
//    [self.headImageView sd_setImageWithURL:imgURL placeholderImage:[UIImage imageNamed:@"App_emp_headimg"]];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat margin = 15;
    
    [self.headImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(margin);
        make.centerY.equalTo(self.mas_centerY);
        make.height.and.width.mas_equalTo(headImageHeight);
    }];
    
    [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.headImageView.mas_right).offset(margin);
        make.right.equalTo(self.mas_right);
    }];

    
}





#pragma mark - Getter

- (UIImageView *)headImageView {
    if (!_headImageView) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:imageV];
        _headImageView      = imageV;
        _headImageView.layer.masksToBounds = YES;
        _headImageView.layer.cornerRadius = headImageHeight / 2;
        _headImageView.layer.borderWidth = 2;
        _headImageView.layer.borderColor =  ICRGB(0xe3e3e3).CGColor;
    }
    return _headImageView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _titleLabel    = label;
        _titleLabel.textColor = ICRGB(0x212121);
        _titleLabel.preferredMaxLayoutWidth = 180;
        _titleLabel.font = [UIFont systemFontOfSize:17.0];
    }
    return _titleLabel;
}




@end
