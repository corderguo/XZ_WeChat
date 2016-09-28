//
//  ICChatBoxMenuView.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/1.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ICEmotionMenuButtonTypeEmoji = 100,
    ICEmotionMenuButtonTypeCuston,
    ICEmotionMenuButtonTypeGif
    
} ICEmotionMenuButtonType;

@class ICChatBoxMenuView;

@protocol ICChatBoxMenuDelegate <NSObject>

@optional
- (void)emotionMenu:(ICChatBoxMenuView *)menu
    didSelectButton:(ICEmotionMenuButtonType)buttonType;

@end

@interface ICChatBoxMenuView : UIView

@property (nonatomic, weak)id <ICChatBoxMenuDelegate>delegate;

@end
