//
//  ICChatMessageVideoCell.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/13.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICChatMessageVideoCell.h"
#import "ICMessageModel.h"
#import "UIImage+Extension.h"
#import "ICMessage.h"
#import "ICVideoManager.h"
#import "ICMediaManager.h"
#import "ZacharyPlayManager.h"
#import "ICAVPlayer.h"
#import "ICFileTool.h"

@interface ICChatMessageVideoCell ()

@property (nonatomic, strong) UIButton *imageBtn;

@property (nonatomic, strong) UIButton *topBtn;


@end

@implementation ICChatMessageVideoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.imageBtn];
        [self.imageBtn addSubview:self.topBtn];
    }
    return self;
}

- (void)setModelFrame:(ICMessageFrame *)modelFrame
{
    [super setModelFrame:modelFrame];
    ICMediaManager *manager = [ICMediaManager sharedManager];

    NSString *path          = [[ICVideoManager shareManager] receiveVideoPathWithFileKey:[modelFrame.model.mediaPath.lastPathComponent stringByDeletingPathExtension]];
    UIImage *videoArrowImage = [manager videoConverPhotoWithVideoPath:path size:modelFrame.picViewF.size isSender:modelFrame.model.isSender];
    
    self.imageBtn.frame = modelFrame.picViewF;
    self.bubbleView.userInteractionEnabled = videoArrowImage != nil;
    self.bubbleView.image = nil;
    [self.imageBtn setImage:videoArrowImage forState:UIControlStateNormal];
    self.topBtn.frame = CGRectMake(0, 0, _imageBtn.width, _imageBtn.height);
}



- (void)imageBtnClick:(UIButton *)btn
{
   __block NSString *path = [[ICVideoManager shareManager] videoPathForMP4:self.modelFrame.model.mediaPath];
    [self videoPlay:path];
}

- (void)videoPlay:(NSString *)path
{
    ICAVPlayer *player = [[ICAVPlayer alloc] initWithPlayerURL:[NSURL fileURLWithPath:path]];
    [player presentFromVideoView:self.imageBtn toContainer:App_RootCtr.view animated:YES completion:nil];
}

#pragma mark - videoPlay

- (void)firstPlay
{
    __block NSString *path = [[ICVideoManager shareManager] videoPathForMP4:self.modelFrame.model.mediaPath];
    if ([ICFileTool fileExistsAtPath:path]) {
        [self reloadStart];
        _topBtn.hidden = YES;
    }
}

-(void)reloadStart {
    __weak typeof(self) weakSelf=self;
    NSString *path = [[ICVideoManager shareManager] videoPathForMP4:self.modelFrame.model.mediaPath];
    [[ZacharyPlayManager sharedInstance] startWithLocalPath:path WithVideoBlock:^(UIImage *imageData, NSString *filePath,CGImageRef tpImage) {
        if ([filePath isEqualToString:path]) {
            [self.imageBtn setImage:imageData forState:UIControlStateNormal];
        }
    }];
    
    [[ZacharyPlayManager sharedInstance] reloadVideo:^(NSString *filePath) {
        MAIN(^{
            if ([filePath isEqualToString:path]) {
                [weakSelf reloadStart];
            }
        });
    } withFile:path];
}

-(void)stopVideo {
    _topBtn.hidden = NO;
    [[ZacharyPlayManager sharedInstance] cancelVideo:[[ICVideoManager shareManager] videoPathForMP4:self.modelFrame.model.mediaPath]];
}

-(void)dealloc {
    [[ZacharyPlayManager sharedInstance] cancelAllVideo];
}

#pragma mark - Getter

- (UIButton *)imageBtn
{
    if (nil == _imageBtn) {
        _imageBtn = [[UIButton alloc] init];
        [_imageBtn addTarget:self action:@selector(imageBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _imageBtn.layer.masksToBounds = YES;
        _imageBtn.layer.cornerRadius = 5;
        _imageBtn.clipsToBounds = YES;
    }
    return _imageBtn;
}

- (UIButton *)topBtn
{
    if (!_topBtn) {
        _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topBtn addTarget:self action:@selector(firstPlay) forControlEvents:UIControlEventTouchUpInside];
        _topBtn.layer.masksToBounds = YES;
        _topBtn.layer.cornerRadius = 5;
    }
    return _topBtn;
}


@end
