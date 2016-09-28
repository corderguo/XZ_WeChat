//
//  ICRecordManager.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/16.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

#define shortRecord @"shortRecord"

@protocol ICRecordManagerDelegate <NSObject>

// voice play finished
- (void)voiceDidPlayFinished;

@end

@interface ICRecordManager : NSObject<AVAudioRecorderDelegate,AVAudioPlayerDelegate>

@property (nonatomic, weak)id <ICRecordManagerDelegate>playDelegate;

@property (nonatomic, strong) AVAudioRecorder *recorder;
@property (nonatomic, strong) AVAudioPlayer *player;

+ (id)shareManager;

// start recording
- (void)startRecordingWithFileName:(NSString *)fileName
                        completion:(void(^)(NSError *error))completion;
// stop recording
- (void)stopRecordingWithCompletion:(void(^)(NSString *recordPath))completion;

// 是否拥有权限
- (BOOL)canRecord;

// 取消当前录制
- (void)cancelCurrentRecording;

- (void)removeCurrentRecordFile:(NSString *)fileName;

/*********-------播放----------************/

- (void)startPlayRecorder:(NSString *)recorderPath;

- (void)stopPlayRecorder:(NSString *)recorderPath;

- (void)pause;


// 接收到的语音保存路径(文件以fileKey为名字)
- (NSString *)receiveVoicePathWithFileKey:(NSString *)fileKey;

// 获取语音时长
- (NSUInteger)durationWithVideo:(NSURL *)voiceUrl;



@end
