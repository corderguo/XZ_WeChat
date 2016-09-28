//
//  ICDetailHeadView.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/21.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat ICTopImageH =  150;

@protocol ICDetailHeadDelegate <NSObject>

- (void)deleteBtnClicked;
- (void)addBtnClicked;
- (void)headBtnClicked:(NSInteger)index;
- (void)changeGroupName;
- (void)changeGroupHeadImg;

@end

@interface ICDetailHeadView : UIView

@property (nonatomic, weak) id<ICDetailHeadDelegate>headDelegate;
@property (nonatomic, strong) NSArray *users;

@property (nonatomic, assign) BOOL isMaster;
@property (nonatomic, strong) XZGroup *group;

@property (nonatomic, strong) UIView *topView;

@end
