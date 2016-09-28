//
//  ICShareButton.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/8.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICShareButton.h"
#import "ICMessageModel.h"
#import "ICMediaManager.h"

@interface ICShareButton ()

@property (nonatomic, weak) UIImageView *imageV;
@property (nonatomic, weak) UILabel *nameLabel;
@property (nonatomic, weak) UILabel *descLabel;
@property (nonatomic, weak) UILabel *fromLabel;
@property (nonatomic, weak) UIView *lineView;

@end

@implementation ICShareButton

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setMessageModel:(ICMessageModel *)messageModel
{
    _messageModel = messageModel;
    ICMessage *message = messageModel.message;
    NSDictionary *dic = [NSDictionary dictionaryWithJsonString:message.fileKey];
    NSString *summary = [dic objectForKey:@"summary"];
    NSString *source  = [dic objectForKey:@"source"];
    ICMediaManager *manager =[ICMediaManager sharedManager];
    UIImage *image = [manager imageWithLocalPath:[manager imagePathWithName:messageModel.mediaPath.lastPathComponent]];
    self.imageV.image = image == nil ? [UIImage imageNamed:@"icon_album_picture_fail_big"] : image;
    self.nameLabel.text = message.content;
    self.descLabel.text = summary;
    self.fromLabel.text = [NSString stringWithFormat:@"来自%@",source];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat leftMargin = 12;
    if (_messageModel.isSender) {
        leftMargin = 12;
    } else {
        leftMargin = 15;
    }
    [self.nameLabel sizeToFit];
    _nameLabel.x = leftMargin;
    _nameLabel.y = 14;
    _nameLabel.width = self.width - 24;
    
    self.imageV.x = leftMargin;
    _imageV.top = _nameLabel.bottom + 12;
    _imageV.width = 48;
    _imageV.height = 50;
    
    self.descLabel.x = _imageV.right+10;
    _descLabel.y     = _imageV.y;
    _descLabel.width = self.width - leftMargin - _imageV.right-10;
    _descLabel.height = _imageV.height;
    
    self.lineView .x = leftMargin;
    _lineView.y  = _descLabel.bottom + 8;
    _lineView.width = self.width - leftMargin*2;
    _lineView.height = 0.5;
    
    self.fromLabel.x = leftMargin;
    _fromLabel.y     = _lineView.bottom;
    _fromLabel.width = self.width - leftMargin*2;
    _fromLabel.height = self.height - _lineView.bottom;
    
}


#pragma mark - Getter

- (UIImageView *)imageV
{
    if (!_imageV) {
        UIImageView *imageV = [[UIImageView alloc] init];
        imageV.contentMode  = UIViewContentModeScaleToFill;
        [self addSubview:imageV];
        _imageV = imageV;
    }
    return _imageV;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = ICRGB(0x262626);
        [self addSubview:label];
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)descLabel
{
    if (!_descLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:11.0];
        label.textColor = ICRGB(0x707070);
        label.numberOfLines = 0;
        [self addSubview:label];
        _descLabel = label;
    }
    return _descLabel;
}

- (UILabel *)fromLabel
{
    if (!_fromLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:10.0];
        label.textColor = ICRGB(0x9d9d9d);
        [self addSubview:label];
        _fromLabel = label;
    }
    return _fromLabel;
}

- (UIView *)lineView
{
    if (!_lineView) {
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = ICRGB(0xc4c4c4);
        [self addSubview:view];
        _lineView = view;
    }
    return _lineView;
}




@end
