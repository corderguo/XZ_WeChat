//
//  ICMessageFrame.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/11.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICMessageFrame.h"
#import "ICMessageModel.h"
#import "NSString+Extension.h"
#import "ICMediaManager.h"
#import "UIImage+Extension.h"
#import "ICMessageConst.h"
#import "ICMessageHelper.h"
#import "ICVideoManager.h"

#define APP_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define APP_HEIGHT ([UIScreen mainScreen].bounds.size.height)


@implementation ICMessageFrame


- (void)setModel:(ICMessageModel *)model
{
    _model = model;
    
    CGFloat headToView    = 10;
    CGFloat headToBubble  = 3;
    CGFloat headWidth     = 45;
    CGFloat cellMargin    = 10;
    CGFloat bubblePadding = 10;
    CGFloat chatLabelMax  = APP_WIDTH - headWidth - 100;
    CGFloat arrowWidth    = 7;      // 气泡箭头
    CGFloat topViewH      = 10;
    CGFloat cellMinW      = 60;     // cell的最小宽度值,针对文本
    
    CGSize timeSize  = CGSizeMake(0, 0);
    if (model.isSender) {
        cellMinW = timeSize.width + arrowWidth + bubblePadding*2;
        CGFloat headX = APP_WIDTH - headToView - headWidth;
        _headImageViewF = CGRectMake(headX, cellMargin, headWidth, headWidth);
        if ([model.message.type isEqualToString:TypeText]) { // 文字
            CGSize chateLabelSize = [model.message.content sizeWithMaxWidth:chatLabelMax andFont:MessageFont];
            CGSize bubbleSize     = CGSizeMake(chateLabelSize.width + bubblePadding * 2 + arrowWidth, chateLabelSize.height + bubblePadding * 2);
            CGSize topViewSize    = CGSizeMake(cellMinW+bubblePadding*2, topViewH);
            _bubbleViewF          = CGRectMake(CGRectGetMinX(_headImageViewF) - headToBubble - bubbleSize.width, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGFloat x             = CGRectGetMinX(_bubbleViewF)+bubblePadding;
            _topViewF             = CGRectMake(CGRectGetMinX(_headImageViewF) - headToBubble - topViewSize.width-headToBubble-5, cellMargin,topViewSize.width,topViewSize.height);
            _chatLabelF           = CGRectMake(x, topViewH + cellMargin + bubblePadding, chateLabelSize.width, chateLabelSize.height);
        } else if ([model.message.type isEqualToString:TypePic]) { // 图片
            CGSize imageSize = CGSizeMake(40, 40);
            UIImage *image   = [UIImage imageWithContentsOfFile:[[ICMediaManager sharedManager] imagePathWithName:model.mediaPath.lastPathComponent]];
            if (image) {
                imageSize          = [self handleImage:image.size];
            }
            imageSize.width        = imageSize.width > timeSize.width ? imageSize.width : timeSize.width;
            CGSize topViewSize     = CGSizeMake(imageSize.width-arrowWidth, topViewH);
            CGSize bubbleSize      = CGSizeMake(imageSize.width, imageSize.height);
            CGFloat bubbleX        = CGRectGetMinX(_headImageViewF)-headToBubble-bubbleSize.width;
            _bubbleViewF           = CGRectMake(bubbleX, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _topViewF             = CGRectMake(x, cellMargin,topViewSize.width,topViewSize.height);
            _picViewF              = CGRectMake(x, cellMargin+topViewH, imageSize.width, imageSize.height);
        } else if ([model.message.type isEqualToString:TypeVoice]) { // 语音消息
            CGFloat bubbleViewW     = 100;
            _bubbleViewF = CGRectMake(CGRectGetMinX(_headImageViewF) - headToBubble - bubbleViewW, cellMargin+topViewH, bubbleViewW, 40);
            _topViewF               = CGRectMake(CGRectGetMinX(_bubbleViewF), cellMargin, bubbleViewW - arrowWidth, topViewH);
            _durationLabelF         = CGRectMake(CGRectGetMinX(_bubbleViewF)+ bubblePadding , cellMargin + 10+topViewH, 50, 20);
            _voiceIconF = CGRectMake(CGRectGetMaxX(_bubbleViewF) - 22, cellMargin + 10 + topViewH, 11, 16.5);// - 20
        }  else if ([model.message.type isEqualToString:TypeVideo]) { // 视频信息
            CGSize imageSize       = CGSizeMake(150, 150);
            UIImage *videoImage = [[ICMediaManager sharedManager] videoImageWithFileName:model.mediaPath.lastPathComponent];
            if (!videoImage) {
                NSString *path          = [[ICVideoManager shareManager] receiveVideoPathWithFileKey:[model.mediaPath.lastPathComponent stringByDeletingPathExtension]];
                videoImage    = [UIImage videoFramerateWithPath:path];
            }
            if (videoImage) {
                float scale        = videoImage.size.height/videoImage.size.width;
                imageSize = CGSizeMake(150, 140*scale);
            }
            CGSize bubbleSize = CGSizeMake(imageSize.width, imageSize.height);
            _bubbleViewF = CGRectMake(CGRectGetMinX(_headImageViewF)-headToBubble-bubbleSize.width, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGSize topViewSize     = CGSizeMake(imageSize.width-arrowWidth, topViewH);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _topViewF              = CGRectMake(x, cellMargin, topViewSize.width, topViewSize.height);
            _picViewF              = CGRectMake(x, cellMargin+topViewH, imageSize.width, imageSize.height);
        } else if ([model.message.type isEqualToString:TypeFile]) {
           CGSize bubbleSize = CGSizeMake(253, 95.0);
            _bubbleViewF = CGRectMake(CGRectGetMinX(_headImageViewF)-headToBubble-bubbleSize.width, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGSize topViewSize     = CGSizeMake(bubbleSize.width-arrowWidth, topViewH);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _topViewF              = CGRectMake(x, cellMargin, topViewSize.width, topViewSize.height);
            _picViewF              = CGRectMake(x, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
        } else if ([model.message.type isEqualToString:TypePicText]) {
            CGSize bubbleSize = CGSizeMake(253, 120.0);
            _bubbleViewF = CGRectMake(CGRectGetMinX(_headImageViewF)-headToBubble-bubbleSize.width, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGSize topViewSize     = CGSizeMake(bubbleSize.width-arrowWidth, topViewH);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _topViewF              = CGRectMake(x, cellMargin, topViewSize.width, topViewSize.height);
            _picViewF              = CGRectMake(x, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
        }
        CGFloat activityX = _bubbleViewF.origin.x-40;
        CGFloat activityY = (_bubbleViewF.origin.y + _bubbleViewF.size.height)/2 - 5;
        CGFloat activityW = 40;
        CGFloat activityH = 40;
        _activityF        = CGRectMake(activityX, activityY, activityW, activityH);
        _retryButtonF     = _activityF;
    } else {    // 接收者
        _headImageViewF   = CGRectMake(headToView, cellMargin, headWidth, headWidth);
        CGSize nameSize       = CGSizeMake(0, 0);
        cellMinW = nameSize.width + 6 + timeSize.width; // 最小宽度
        if ([model.message.type isEqualToString:TypeText]) {
            CGSize chateLabelSize = [model.message.content sizeWithMaxWidth:chatLabelMax andFont:MessageFont];
            CGSize topViewSize    = CGSizeMake(cellMinW+bubblePadding*2, topViewH);
            CGSize bubbleSize = CGSizeMake(chateLabelSize.width + bubblePadding * 2 + arrowWidth, chateLabelSize.height + bubblePadding * 2);
            
            _bubbleViewF  = CGRectMake(CGRectGetMaxX(_headImageViewF) + headToBubble, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGFloat x     = CGRectGetMinX(_bubbleViewF) + bubblePadding + arrowWidth;
            _topViewF     = CGRectMake(CGRectGetMinX(_bubbleViewF)+arrowWidth, cellMargin, topViewSize.width, topViewSize.height);
            _chatLabelF   = CGRectMake(x, cellMargin + bubblePadding + topViewH, chateLabelSize.width, chateLabelSize.height);
        } else if ([model.message.type isEqualToString:TypePic]) {
            CGSize imageSize = CGSizeMake(40, 40);
            UIImage *image   = [UIImage imageWithContentsOfFile:[[ICMediaManager sharedManager] imagePathWithName:model.mediaPath.lastPathComponent]];
            if (image) {
                imageSize = [self handleImage:image.size];
            }
            imageSize.width        = imageSize.width > cellMinW ? imageSize.width : cellMinW;
            CGSize topViewSize     = CGSizeMake(imageSize.width-arrowWidth, topViewH);
            CGSize bubbleSize      = CGSizeMake(imageSize.width, imageSize.height);
            CGFloat bubbleX        = CGRectGetMaxX(_headImageViewF)+headToBubble;
            _bubbleViewF           = CGRectMake(bubbleX, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _topViewF              = CGRectMake(x+arrowWidth, cellMargin, topViewSize.width, topViewSize.height);
            _picViewF              = CGRectMake(x, cellMargin+topViewH, imageSize.width, imageSize.height);

        } else if ([model.message.type isEqualToString:TypeVoice]) {   // 语音
            CGFloat bubbleViewW = cellMinW + 20; // 加上一个红点的宽度
            CGFloat voiceToBull = 4;
            
            _bubbleViewF = CGRectMake(CGRectGetMaxX(_headImageViewF) + headToBubble, cellMargin+topViewH, bubbleViewW, 40);
            _topViewF    = CGRectMake(CGRectGetMinX(_bubbleViewF)+arrowWidth, cellMargin, bubbleViewW-arrowWidth, topViewH);
             _voiceIconF = CGRectMake(CGRectGetMinX(_bubbleViewF)+arrowWidth+bubblePadding, cellMargin + 10 + topViewH, 11, 16.5);
            // 假设
            NSString *duraStr = @"100";
            CGSize durSize = [duraStr sizeWithMaxWidth:chatLabelMax andFont:[UIFont systemFontOfSize:14]];
            _durationLabelF = CGRectMake(CGRectGetMaxX(_bubbleViewF) - voiceToBull - durSize.width, cellMargin + 10 + topViewH, durSize.width, durSize.height);
            _redViewF = CGRectMake(CGRectGetMaxX(_bubbleViewF) + 6, CGRectGetMinY(_bubbleViewF) + _bubbleViewF.size.height*0.5-4, 8, 8);
        } else if ([model.message.type isEqualToString:TypeVideo]) {   // 视频
            CGSize imageSize       = CGSizeMake(150, 150);
            UIImage *videoImage = [[ICMediaManager sharedManager] videoImageWithFileName:[NSString stringWithFormat:@"%@.png",model.message.fileKey]];
            if (!videoImage) {
                NSString *path          = [[ICVideoManager shareManager] receiveVideoPathWithFileKey:model.message.fileKey];
                videoImage    = [UIImage videoFramerateWithPath:path];
            }
            if (videoImage) {
                float scale        = videoImage.size.height/videoImage.size.width;
                imageSize = CGSizeMake(150, 140*scale);
            }
            CGSize bubbleSize = CGSizeMake(imageSize.width, imageSize.height+topViewH);
            _bubbleViewF = CGRectMake(CGRectGetMaxX(_headImageViewF)+headToBubble, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGSize topViewSize     = CGSizeMake(imageSize.width-arrowWidth, topViewH);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _topViewF              = CGRectMake(x+arrowWidth, cellMargin, topViewSize.width, topViewSize.height);
            _picViewF              = CGRectMake(x, cellMargin+topViewH, imageSize.width, imageSize.height);
        } else if ([model.message.type isEqualToString:TypeSystem]) {
            CGSize size           = [model.message.content sizeWithMaxWidth:APP_WIDTH-40 andFont:[UIFont systemFontOfSize:11.0]];
            _bubbleViewF = CGRectMake(0, 0, 0, size.height+10);// 只需要高度就行
        } else if ([model.message.type isEqualToString:TypeFile]) {
            CGSize bubbleSize = CGSizeMake(253, 95.0);
            _bubbleViewF = CGRectMake(CGRectGetMaxX(_headImageViewF)+headToBubble, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGSize topViewSize     = CGSizeMake(bubbleSize.width-arrowWidth, topViewH);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _topViewF              = CGRectMake(x+arrowWidth, cellMargin, topViewSize.width, topViewSize.height);
            _picViewF              = CGRectMake(x, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
        } else if ([model.message.type isEqualToString:TypePicText]) {
            CGSize bubbleSize = CGSizeMake(253, 120.0);
            _bubbleViewF = CGRectMake(CGRectGetMaxX(_headImageViewF)+headToBubble, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
            CGSize topViewSize     = CGSizeMake(bubbleSize.width-arrowWidth, topViewH);
            CGFloat x              = CGRectGetMinX(_bubbleViewF);
            _topViewF              = CGRectMake(x+arrowWidth, cellMargin, topViewSize.width, topViewSize.height);
            _picViewF              = CGRectMake(x, cellMargin+topViewH, bubbleSize.width, bubbleSize.height);
        }
        
    }
    _cellHight = MAX(CGRectGetMaxY(_bubbleViewF), CGRectGetMaxY(_headImageViewF)) + cellMargin;
    if ([model.message.type isEqualToString:TypeSystem]) {
        CGSize size           = [model.message.content sizeWithMaxWidth:[UIScreen mainScreen].bounds.size.width-40 andFont:[UIFont systemFontOfSize:11.0]];
        _cellHight = size.height+10;
    }
}


    
// 缩放，临时的方法
- (CGSize)handleImage:(CGSize)retSize
{
    CGFloat scaleH = 0.22;
    CGFloat scaleW = 0.38;
    CGFloat height = 0;
    CGFloat width = 0;
    if (retSize.height / APP_HEIGHT + 0.16 > retSize.width / APP_WIDTH) {
        height = APP_HEIGHT * scaleH;
        width = retSize.width / retSize.height * height;
    } else {
        width = APP_WIDTH * scaleW;
        height = retSize.height / retSize.width * width;
    }
    return CGSizeMake(width, height);
}







@end
