//
//  XZConstants.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/9/27.
//  Copyright © 2016年 gxz. All rights reserved.
//

#ifndef XZConstants_h
#define XZConstants_h


#define APP_Frame_Height   [[UIScreen mainScreen] bounds].size.height

#define App_Frame_Width    [[UIScreen mainScreen] bounds].size.width

#define ALERT(msg)  [[[UIAlertView alloc]initWithTitle:@"提示" message:msg delegate:nil \
cancelButtonTitle:@"确定" otherButtonTitles:nil,nil] show]

#define App_Delegate ((AppDelegate*)[[UIApplication sharedApplication]delegate])

#define App_RootCtr  [UIApplication sharedApplication].keyWindow.rootViewController

#define WEAKSELF __weak typeof(self) weakSelf = self;

#define XZColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define IColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define XZRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define ICRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]

#define BACKGROUNDCOLOR   XZRGB(0xf4f1f1)
#define SEARCHBACKGROUNDCOLOR  [UIColor colorWithRed:(110.0)/255.0 green:(110.0)/255.0 blue:(110.0)/255.0 alpha:0.4]


#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);


#define ICFont(FONTSIZE)  [UIFont systemFontOfSize:(FONTSIZE)]
#define ICBOLDFont(FONTSIZE)  [UIFont boldSystemFontOfSize:(FONTSIZE)]
#define ICSEARCHCANCELCOLOR    [UIColor orangeColor]
#define SEARCH_HEIGHT_COLOR   ICRGB(0x027996)

//#define NE_BACKGROUND_COLOR ICRGB(0x347b97)
#define NE_BACKGROUND_COLOR ICRGB(0x027996)

#define kDiscvoerVideoPath @"Download/Video"  // video子路径
#define kChatVideoPath @"Chat/Video"  // video子路径
#define kVideoType @".mp4"        // video类型
#define kRecoderType @".wav"


#define kChatRecoderPath @"Chat/Recoder"
#define kRecodAmrType @".amr"



#endif /* XZConstants_h */
