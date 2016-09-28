//
//  ICMessageModel.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/12.
//  Copyright © 2016年 gxz All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ICMessage.h"

@interface ICMessageModel : NSObject

// 后期重构把这个类可能要去掉--by:gxz

// 是否是发送者
@property (nonatomic, assign) BOOL isSender;
// 是否是群聊
//@property (nonatomic, assign) BOOL isChatGroup;


@property (nonatomic, strong) ICMessage * message;

// 包含voice，picture，video的路径;有大图时就是大图路径
// 不用这些路径了，只用里面的名字重新组成路径
@property (nonatomic, copy) NSString *mediaPath;


@end
