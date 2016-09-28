//
//  ICAudioView.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/8/17.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ICAudioView : UIView


@property (nonatomic, copy) NSString *audioName;

@property (nonatomic, copy) NSString *audioPath;

- (void)releaseTimer;


@end
