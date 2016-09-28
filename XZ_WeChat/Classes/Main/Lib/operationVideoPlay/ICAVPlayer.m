//
//  ICAVPlayer.m
//  XZ_WeChat
//
//  Created by guoxianzhuang on 16/7/6.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICAVPlayer.h"
@interface ICAVPlayer ()
@property (nonatomic, weak) UIView *fromView;
@property (nonatomic, weak) UIView *toContainerView;
@property (nonatomic, assign) BOOL fromNavigationBarHidden;

@end
@implementation ICAVPlayer
- (instancetype)initWithPlayerURL:(NSURL *)URL {
    self = [super init];
    if (self){
        self.backgroundColor = [UIColor blackColor];
        
        //设置player的参数
        self.currentItem = [AVPlayerItem playerItemWithURL:URL];
        self.player = [AVPlayer playerWithPlayerItem:self.currentItem];
        self.player.usesExternalPlaybackWhileExternalScreenIsActive=YES;
        //AVPlayerLayer
        self.playerLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
        self.playerLayer.videoGravity = AVLayerVideoGravityResize;
        [self.layer addSublayer:self.playerLayer];
        [self.player play];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [self dismissAnimated:YES completion:nil];
        }];
        [self addGestureRecognizer:tap];
        
        // 循环播放
        _player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
        [[NSNotificationCenter defaultCenter]addObserver:self
                                                selector:@selector(playerItemDidPlayToEndTimeNotification:)
                                                    name:AVPlayerItemDidPlayToEndTimeNotification
                                                  object:nil];
    }
    return self;
}

- (void)dismissAnimated:(BOOL)animated completion:(void (^)(void))completion {
    [UIView setAnimationsEnabled:YES];
    [[UIApplication sharedApplication] setStatusBarHidden:_fromNavigationBarHidden withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
    if ([self.delegate respondsToSelector:@selector(closePlayerViewAction)]) {
        [self.delegate closePlayerViewAction];
    }
    float oneTime = animated ? 0.5 : 0;
    
    [UIView animateWithDuration:oneTime delay:0 options:UIViewAnimationOptionBeginFromCurrentState|UIViewAnimationOptionCurveEaseInOut animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self releasePlayer];
        if (completion) completion();
    }];
    
}

- (void)presentFromVideoView:(UIView *)fromView
                 toContainer:(UIView *)toContainer
                    animated:(BOOL)animated
                  completion:(void (^)(void))completion{
    _toContainerView = toContainer == nil ? App_RootCtr.view : toContainer;
    
    _fromView = fromView;
    
    [_toContainerView addSubview:self];
    
    CGFloat height = fromView.size.height * App_Frame_Width / fromView.size.width;
    
    self.frame = CGRectMake(0, 0, App_Frame_Width, APP_Frame_Height);
    
    self.alpha = 0;
    
    float oneTime = animated ? 0.5 : 0;
    
    [UIView animateWithDuration:oneTime animations:^{
        self.playerLayer.frame = CGRectMake(0, APP_Frame_Height / 2 - height / 2, App_Frame_Width, height);
        self.alpha = 1;
    }];
    _fromNavigationBarHidden = [UIApplication sharedApplication].statusBarHidden;
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:animated ? UIStatusBarAnimationFade : UIStatusBarAnimationNone];
    if (completion) completion();
}

- (void)playerItemDidPlayToEndTimeNotification:(NSNotification *)sender {
    [self.player seekToTime:kCMTimeZero]; // seek to zero
}
-(void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self releasePlayer];
}

- (void)releasePlayer {
    [self.player.currentItem cancelPendingSeeks];
    [self.player.currentItem.asset cancelLoading];
    [self.player pause];
    [self removeFromSuperview];
    [self.playerLayer removeFromSuperlayer];
    [self.player replaceCurrentItemWithPlayerItem:nil];
    self.player = nil;
    self.currentItem = nil;
    self.playerLayer = nil;
}

@end
