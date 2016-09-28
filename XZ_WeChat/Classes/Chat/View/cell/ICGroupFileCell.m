//
//  ICGroupFileCell.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/8/16.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICGroupFileCell.h"
#import "ICFileTool.h"
#import "NSDate+Extension.h"

@interface ICGroupFileCell ()

@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *sizeLabel;
@property (nonatomic, weak) UILabel *subLabel;



@end

@implementation ICGroupFileCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.leftFreeSpace = 79;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"groupFileCell";
    ICGroupFileCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[ICGroupFileCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}


- (void)setMessage:(ICMessage *)message
{
    _message = message;
    
    NSDictionary *dic = [NSDictionary dictionaryWithJsonString:message.lnk];
    NSNumber * size   = [dic objectForKey:@"s"];
    NSNumber * type   = [dic objectForKey:@"x"];
    NSString * name   = [dic objectForKey:@"n"];
    
    self.imageV.image   = [ICMessageHelper allocationImage:type.intValue];
    self.sizeLabel.text = [ICFileTool fileSizeWithInteger:size.integerValue];
    self.nameLabel.text = name;
//    NSString *date = [NSDate dateWithFormatter:@"YYYY/MM/dd HH:mm" timeInterval:message.date/1000.0];
//    NSString * eName = [ICMessageDatabase getUserNameWithEId:message.from];
//    self.subLabel.text  = [NSString stringWithFormat:@"%@ 来自%@",date,eName];
    
    [self fileExisted:message.fileKey];
    
}

- (void)fileExisted:(NSString *)fileKey
{
    BOOL isExisted = NO;
    NSDirectoryEnumerator *enumer = [[NSFileManager defaultManager] enumeratorAtPath:[ICFileTool fileMainPath]];
    NSString *name ;
    while (name = [enumer nextObject]) {
        if ([name hasPrefix:fileKey]) {
            isExisted = YES;
            break;
        }
    }
    if (isExisted) {
        [self.seeBtn setTitle:@"查看" forState:UIControlStateNormal];
    } else {
        [self.seeBtn setTitle:@"下载" forState:UIControlStateNormal];
    }
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.imageV.frame    = CGRectMake(14, 15, 55, 55);
    _imageV.centerY      = self.height*0.5;
    self.nameLabel.frame = CGRectMake(_imageV.right+10, 15, App_Frame_Width-_imageV.right-10-40, 16);
    [_nameLabel sizeToFit];
    _nameLabel.width = App_Frame_Width-_imageV.right-10-60;
    self.sizeLabel.frame = CGRectMake(_imageV.right+10,_nameLabel.bottom+4 , 50, 15);
    [_sizeLabel sizeToFit];
    
    self.subLabel.frame = CGRectMake(_imageV.right+10, _sizeLabel.bottom+6, _nameLabel.width, 16);
    [_subLabel sizeToFit];
    
    self.seeBtn.frame = CGRectMake(App_Frame_Width-15-40, 20, 40, 30);
    self.seeBtn.centerY = self.height*0.5;
    
    self.progressView.frame = CGRectMake(_imageV.right+10,_subLabel.bottom+5, _seeBtn.right-_imageV.right-10-3, 8);
}

#pragma mark - Event

- (void)seeBtnClicked:(UIButton *)btn
{
    if ([self.delegate respondsToSelector:@selector(isFileExisted:isExisted:fileKey:fileName:)]) {
        [self.delegate isFileExisted:self isExisted:[btn.titleLabel.text isEqualToString:@"查看"] fileKey:_message.fileKey fileName:_nameLabel.text];
    }
}

#pragma mark - Getter

- (UIImageView *)imageV
{
    if (!_imageV) {
        UIImageView *imageV = [[UIImageView alloc] init];
        [self.contentView addSubview:imageV];
        _imageV = imageV;
    }
    return _imageV;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _nameLabel = label;
        _nameLabel.font = [UIFont systemFontOfSize:15.0];
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _nameLabel.textColor = ICRGB(0x000000);
    }
    return _nameLabel;
}

- (UILabel *)sizeLabel
{
    if (!_sizeLabel) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _sizeLabel = label;
        _sizeLabel.font = [UIFont systemFontOfSize:11.0];
        _sizeLabel.textColor = ICRGB(0x7e7e7e);
    }
    return _sizeLabel;
}

- (UILabel *)subLabel
{
    if (!_subLabel) {
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _subLabel = label;
        _subLabel.font = [UIFont systemFontOfSize:11.0];
        _subLabel.textColor = ICRGB(0x7e7e7e);
    }
    return _subLabel;
}

- (UIButton *)seeBtn
{
    if (!_seeBtn) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:btn];
        _seeBtn = btn;
        _seeBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        [_seeBtn setTitleColor:ICRGB(0x027996) forState:UIControlStateNormal];
        [_seeBtn addTarget:self action:@selector(seeBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _seeBtn;
}

- (UIProgressView *)progressView
{
    if (!_progressView) {
        UIProgressView *progressView = [[UIProgressView alloc] init];
        [self.contentView addSubview:progressView];
        _progressView = progressView;
        _progressView.hidden = YES;
        _progressView.progressTintColor = [UIColor greenColor];
    }
    return _progressView;
}








@end
