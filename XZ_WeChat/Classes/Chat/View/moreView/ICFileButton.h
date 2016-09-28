//
//  ICFileButton.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/7/21.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

@class ICMessageModel;

@interface ICFileButton : UIButton

@property (nonatomic, strong) ICMessageModel *messageModel;

@property (nonatomic, strong) UILabel *identLabel;

@property (nonatomic, strong) UIProgressView *progressView;

@end
