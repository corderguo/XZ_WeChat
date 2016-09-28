//
//  ICChatServerDefs.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/4/7.
//  Copyright © 2016年 gxz All rights reserved.
//

#ifndef ICChatServerDefs_h
#define ICChatServerDefs_h

// 消息发送状态
typedef enum {
    ICMessageDeliveryState_Pending = 0,  // 待发送
    ICMessageDeliveryState_Delivering,   // 正在发送
    ICMessageDeliveryState_Delivered,    // 已发送，成功
    ICMessageDeliveryState_Failure,      // 发送失败
    ICMessageDeliveryState_ServiceFaid   // 发送服务器失败(可能其它错,待扩展)
}MessageDeliveryState;


// 消息类型
typedef enum {
    ICMessageType_Text  = 1,             // 文本
    ICMessageType_Voice,                 // 短录音
    ICMessageType_Image,                 // 图片
    ICMessageType_Video,                 // 短视频
    ICMessageType_Doc,                   // 文档
    ICMessageType_TextURL,               // 文本＋链接
    ICMessageType_ImageURL,              // 图片＋链接
    ICMessageType_URL,                   // 纯链接
    ICMessageType_DrtNews,               // 送达号
    ICMessageType_NTF   = 12,            // 通知
    
    ICMessageType_DTxt  = 21,            // 纯文本
    ICMessageType_DPic  = 22,            // 文本＋单图
    ICMessageType_DMPic = 23,            // 文本＋多图
    ICMessageType_DVideo= 24,            // 文本＋视频
    ICMessageType_PicURL= 25             // 动态图文链接
    
}ICMessageType;

typedef enum {
    ICGroup_SELF = 0,                    // 自己
    ICGroup_DOUBLE,                      // 双人组
    ICGroup_MULTI,                       // 多人组
    ICGroup_TODO,                        // 待办
    ICGroup_QING,                        // 轻应用
    ICGroup_NATIVE,                      // 原生应用
    ICGroup_DISCOVERY,                   // 发现
    ICGroup_DIRECT,                      // 送达号
    ICGroup_NOTIFY,                      // 通知
    ICGroup_BOOK                         // 通讯录
}ICGroupType;

// 消息状态
typedef enum {
    ICMessageStatus_unRead = 0,          // 消息未读
    ICMessageStatus_read,                // 消息已读
    ICMessageStatus_back                 // 消息撤回
}ICMessageStatus;

typedef enum {
    ICActionType_READ = 1,               // 语音已读
    ICActionType_BACK,                   // 消息撤回
    ICActionType_UPTO,                   // 消息读数
    ICActionType_KICK,                   // 请出会话
    ICActionType_OPOK,                   // 待办已办
    ICActionType_BDRT,                   // 送达号消息撤回
    ICActionType_GUPD,                   // 群信息修改
    ICActionType_UUPD,                   // 群成员信息修改
    ICActionType_DUPD,                   // 送达号信息修改
    ICActionType_OFFL = 10,              // 请您下线
    ICActionType_STOP = 11,              // 清除所有缓存
    ICActionType_UUPN                    // 改昵称

}ICActionType;

typedef NS_ENUM(NSInteger, ICChatBoxStatus) {
    ICChatBoxStatusNothing,     // 默认状态
    ICChatBoxStatusShowVoice,   // 录音状态
    ICChatBoxStatusShowFace,    // 输入表情状态
    ICChatBoxStatusShowMore,    // 显示“更多”页面状态
    ICChatBoxStatusShowKeyboard,// 正常键盘
    ICChatBoxStatusShowVideo    // 录制视频
};

typedef enum {
    ICDeliverSubStatus_Can        = 0,   // 可订阅
    ICDeliverSubStatus_Already,
    ICDeliverSubStatus_System
}ICDeliverSubStatus;

typedef enum {
    ICDeliverTopStatus_NO         = 0, // 非置顶
    ICDeliverTopStatus_YES             // 置顶
}ICDeliverTopStatus;


typedef enum {
    ICFileType_Other = 0,                // 其它类型
    ICFileType_Audio,                    //
    ICFileType_Video,                    //
    ICFileType_Html,
    ICFileType_Pdf,
    ICFileType_Doc,
    ICFileType_Xls,
    ICFileType_Ppt,
    ICFileType_Img,
    ICFileType_Txt
}ICFileType;


#endif /* ICChatServerDefs_h */
