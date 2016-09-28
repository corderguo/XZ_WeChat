//
//  ICChatMessageFileCell.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/7/20.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICChatMessageFileCell.h"
#import "ICFileButton.h"
#import "ICMessageModel.h"
#import "ICFileTool.h"

@interface ICChatMessageFileCell ()

@property (nonatomic, strong) ICFileButton *fileButton;

@end

@implementation ICChatMessageFileCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.fileButton];
    }
    return self;
}


- (void)setModelFrame:(ICMessageFrame *)modelFrame
{
    [super setModelFrame:modelFrame];
    
    self.fileButton.frame = modelFrame.picViewF;
    self.fileButton.messageModel = modelFrame.model;
    
    if ([ICFileTool fileExistsAtPath:[self localFilePath]]) {
        if (modelFrame.model.isSender) {
            if (modelFrame.model.message.deliveryState == ICMessageDeliveryState_Delivered) {
                self.fileButton.identLabel.text = @"已发送";
            } else {
                self.fileButton.identLabel.text = @"未发送";
            }
        } else {
            self.fileButton.identLabel.text = @"已下载";
        }
    } else {
        if (modelFrame.model.isSender) {
            if (modelFrame.model.message.deliveryState == ICMessageDeliveryState_Delivered) {
                self.fileButton.identLabel.text = @"已发送";
            } else {
                self.fileButton.identLabel.text = @"未发送";
            }
        } else {
            self.fileButton.identLabel.text = @"未下载";
        }
    }
}


#pragma mark - Event

- (void)fileBtnClicked:(UIButton *)fileBtn
{
    // 如果文件存在就直接打开，否者下载
    __block NSString *path = [self localFilePath];
    if ([ICFileTool fileExistsAtPath:path]) {
        [self routerEventWithName:GXRouterEventScanFile
                         userInfo:@{
                                    MessageKey   : self.modelFrame,
                                    @"filePath"  : path,
                                    @"fileBtn"   : fileBtn
                                    }
         ];
        return;
    }
    NSString *fileKey = self.modelFrame.model.message.fileKey;
    if (!fileKey) return;
    self.fileButton.progressView.hidden = NO;
}


- (NSString *)localFilePath
{
    NSString *lnk = self.modelFrame.model.message.lnk;
    NSDictionary *dicLnk = [NSDictionary dictionaryWithJsonString:lnk];
    NSString *orgName  = [dicLnk objectForKey:@"n"];
    NSString *key      = self.modelFrame.model.message.fileKey;
    NSString *path = [ICFileTool filePathWithName:key orgName:[orgName stringByDeletingPathExtension] type:[orgName pathExtension]];
    
    return path;
}


#pragma mark - Getter

- (ICFileButton *)fileButton
{
    if (!_fileButton) {
        _fileButton = [ICFileButton buttonWithType:UIButtonTypeCustom];
        [_fileButton addTarget:self action:@selector(fileBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _fileButton;
}



@end
