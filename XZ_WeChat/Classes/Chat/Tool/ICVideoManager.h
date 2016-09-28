//
//  ICVideoManager.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/22.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^RecordingFinished)(NSString *path);

@interface ICVideoManager : NSObject

+ (instancetype)shareManager;

- (void)setVideoPreviewLayer:(UIView *)videoLayerView;


- (void)startRecordingVideoWithFileName:(NSString *)videoName;

// 录制权限
- (BOOL)canRecordViedo;

// stop recording
- (void)stopRecordingVideo:(RecordingFinished)finished;

- (void)cancelRecordingVideoWithFileName:(NSString *)videoName;

// 退出
- (void)exit;

// 接收到的视频保存路径(文件以fileKey为名字)
- (NSString *)receiveVideoPathWithFileKey:(NSString *)fileKey;

- (NSString *)videoPathWithFileName:(NSString *)videoName;

- (NSString *)videoPathForMP4:(NSString *)namePath;
// 自定义路径
- (NSString *)videoPathWithFileName:(NSString *)videoName fileDir:(NSString *)fileDir;




@end
