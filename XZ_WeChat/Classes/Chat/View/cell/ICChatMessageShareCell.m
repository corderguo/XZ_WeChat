//
//  ICChatMessageShareCell.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/8.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICChatMessageShareCell.h"
#import "ICShareButton.h"
#import "ICMessageModel.h"

@interface ICChatMessageShareCell ()

@property (nonatomic, strong) ICShareButton *shareButton;

@end

@implementation ICChatMessageShareCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.shareButton];
    }
    return self;
}



- (void)setModelFrame:(ICMessageFrame *)modelFrame
{
    [super setModelFrame:modelFrame];
    
    self.shareButton.frame = modelFrame.picViewF;
    self.shareButton.messageModel = modelFrame.model;
}

#pragma mark - Event

- (void)shareBtnClicked
{
    [self routerEventWithName:GXRouterEventShareTapEvent
                     userInfo:@{MessageKey   : self.modelFrame,
                                }];
}

#pragma mark - Getter

- (ICShareButton *)shareButton
{
    if (!_shareButton) {
        _shareButton = [ICShareButton buttonWithType:UIButtonTypeCustom];
        [_shareButton addTarget:self action:@selector(shareBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _shareButton;
}







@end
