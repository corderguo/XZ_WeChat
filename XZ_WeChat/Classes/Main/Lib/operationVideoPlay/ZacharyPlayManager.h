//
//  ZacharyPlayManager.h
//  VideoPlayer
//
//  Created by eleme on 16/4/26.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VideoPlayOperation.h"

@interface ZacharyPlayManager : NSObject
{
    NSOperationQueue *videoQueue;
    NSMutableDictionary *videoDecode;
    

}

@property(nonatomic,strong)NSMutableDictionary *videoDecode;
@property(nonatomic,strong)NSOperationQueue *videoQueue;


+(ZacharyPlayManager*) sharedInstance;
// 本地 videoPath   block中播放的imageview
-(void)startWithLocalPath:(NSString *)filePath WithVideoBlock:(VideoCode)videoImage;
-(void)reloadVideo:(VideoStop) stop withFile:(NSString *)filePath;
-(void)cancelVideo:(NSString *)filePath;
-(void)cancelAllVideo;


@end
