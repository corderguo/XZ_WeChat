//
//  ICChatBoxFaceView.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/11.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICChatBoxFaceView.h"
#import "ICChatBoxMenuView.h"
#import "ICEmotionListView.h"
#import "ICFaceManager.h"

#define bottomViewH 36.0

@interface ICChatBoxFaceView ()<UIScrollViewDelegate,ICChatBoxMenuDelegate>

@property (nonatomic, weak) ICEmotionListView *showingListView;

@property (nonatomic, strong) ICEmotionListView *emojiListView;
@property (nonatomic, strong) ICEmotionListView *custumListView;
@property (nonatomic, strong) ICEmotionListView *gifListView;

@property (nonatomic, weak) ICChatBoxMenuView *menuView;

@end

@implementation ICChatBoxFaceView

- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        ICChatBoxMenuView *menuView = [[ICChatBoxMenuView alloc] init];
        [menuView setDelegate:self];
        [self addSubview:menuView];
        _menuView = menuView;
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            self.custumListView.emotions = [ICFaceManager customEmotion];
        });
        
       // 如果表情选中的时候需要动画或者其它操作,则在这里监听通知
    }
    return self;
}



#pragma mark - Private

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.menuView.width         = self.width;
    self.menuView.height        = bottomViewH;
    self.menuView.x             = 0;
    self.menuView.y             = self.height - self.menuView.height;
    
    self.showingListView.x      = self.showingListView.y = 0;
    self.showingListView.width  = self.width;
    self.showingListView.height = self.menuView.y;
}


#pragma mark - ICChatBoxMenuDelegate

- (void)emotionMenu:(ICChatBoxMenuView *)menu didSelectButton:(ICEmotionMenuButtonType)buttonType
{
    [self.showingListView removeFromSuperview];
    switch (buttonType) {
        case ICEmotionMenuButtonTypeEmoji:
            [self addSubview:self.emojiListView];
            break;
        case ICEmotionMenuButtonTypeCuston:
            [self addSubview:self.custumListView];
            break;
        case ICEmotionMenuButtonTypeGif:
            [self addSubview:self.gifListView];
            break;
        default:
            break;
    }
    self.showingListView = [self.subviews lastObject];
    [self setNeedsLayout];
}


#pragma mark - Getter

- (ICEmotionListView *)emojiListView
{
    if (!_emojiListView) {
        _emojiListView           = [[ICEmotionListView alloc] init];
        _emojiListView.emotions  = [ICFaceManager emojiEmotion];
    }
    return _emojiListView;
}

- (ICEmotionListView *)gifListView
{
    if (!_gifListView) {
        _gifListView             = [[ICEmotionListView alloc] init];
    }
    return _gifListView;
}

- (ICEmotionListView *)custumListView
{
    if (!_custumListView) {
        _custumListView          = [[ICEmotionListView alloc] init];
        _custumListView.emotions = [ICFaceManager customEmotion];
    }
    return _custumListView;
}




@end
