//
//  ICAVPlayer.h
//  XZ_WeChat
//
//  Created by guoxianzhuang on 16/7/6.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>
@class ICAVPlayer;
@protocol ICAVPlayerDelegate <NSObject>

@optional

-(void)closePlayerViewAction;

@end
@interface ICAVPlayer : UIView
/**
 *  播放器player
 */
@property (nonatomic, strong)AVPlayer       *player;
/**
 * playerLayer
 */
@property (nonatomic, strong)AVPlayerLayer  *playerLayer;
/**
 * 播放器的代理
 */
@property (nonatomic, weak)id <ICAVPlayerDelegate> delegate;
/**
 *  当前播放的item
 */
@property (nonatomic, strong)AVPlayerItem   *currentItem;
/**
 *  给一个本地视频url
 */
- (instancetype)initWithPlayerURL:(NSURL *)URL;
/**
 *  show player view
 *
 *  @param fromView    cell 中的videoImageView 必须给
 *  @param toContainer 播放器需显示的view  为nil则 默认给个App_RootCtr.view
 *  @param animated    动画
 */
- (void)presentFromVideoView:(UIView *)fromView
                 toContainer:(UIView *)toContainer
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion;

@end
