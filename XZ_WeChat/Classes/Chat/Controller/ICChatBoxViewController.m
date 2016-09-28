//
//  ICChatBoxViewController.m
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/10.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICChatBoxViewController.h"
#import "ICChatBoxMoreView.h"
#import "ICChatBoxFaceView.h"
#import "ICMessage.h"
#import "ICMediaManager.h"
#import "ICVideoView.h"
#import "ICMessageConst.h"
#import "ICVideoManager.h"
#import "UIImage+Extension.h"
#import "ICDocumentViewController.h"
#import "ICTools.h"

@interface ICChatBoxViewController ()<ICChatBoxDelegate,ICChatBoxMoreViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate,ICDocumentDelegate>

@property (nonatomic, assign) CGRect keyboardFrame;

//@property (nonatomic, strong) ICChatBox *chatBox;
/** chatBar more view */
@property (nonatomic, strong) ICChatBoxMoreView *chatBoxMoreView;
/** emoji face */
@property (nonatomic, strong) ICChatBoxFaceView *chatBoxFaceView;
/** 录音文件名 */
@property (nonatomic, copy) NSString *recordName;
@property (nonatomic, strong) UIImagePickerController *imagePicker;

@property (nonatomic, weak) ICVideoView *videoView;

@end

@implementation ICChatBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.chatBox];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

#pragma mark - Public Methods

- (BOOL)resignFirstResponder
{
    if (self.chatBox.status == ICChatBoxStatusShowVideo) { // 录制视频状态
        if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
            [UIView animateWithDuration:0.3 animations:^{
                [_delegate chatBoxViewController:self didChangeChatBoxHeight:HEIGHT_TABBAR];
            } completion:^(BOOL finished) {
                [self.videoView removeFromSuperview]; // 移除video视图
                self.chatBox.status = ICChatBoxStatusNothing;//同时改变状态
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                   [[ICVideoManager shareManager] exit];  // 防止内存泄露
                });
            }];
        }
        return [super resignFirstResponder];
    }
    if (self.chatBox.status != ICChatBoxStatusNothing && self.chatBox.status != ICChatBoxStatusShowVoice) {
        [self.chatBox resignFirstResponder];
        if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
            [UIView animateWithDuration:0.3 animations:^{
                [_delegate chatBoxViewController:self didChangeChatBoxHeight:HEIGHT_TABBAR];
            } completion:^(BOOL finished) {
                [self.chatBoxFaceView removeFromSuperview];
                [self.chatBoxMoreView removeFromSuperview];
                // 状态改变
                self.chatBox.status = ICChatBoxStatusNothing;
            }];
        }

    }
    return [super resignFirstResponder];
}

- (BOOL)becomeFirstResponder
{
    return [super becomeFirstResponder];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo
{
    if ([eventName isEqualToString:GXRouterEventVideoRecordExit]) {
        [self resignFirstResponder];
    } else if ([eventName isEqualToString:GXRouterEventVideoRecordFinish]) {
        NSString *videoPath = userInfo[VideoPathKey];
        [self resignFirstResponder];
        if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:sendVideoMessage:)]) {
            [_delegate chatBoxViewController:self sendVideoMessage:videoPath];
        }
    } else if ([eventName isEqualToString:GXRouterEventVideoRecordCancel]) {
        ICLog(@"record cancel");
    } 
}

#pragma mark - Private Methods

- (NSString *)currentRecordFileName
{
    NSTimeInterval timeInterval = [[NSDate date] timeIntervalSince1970];
    NSString *fileName = [NSString stringWithFormat:@"%ld",(long)timeInterval];
    return fileName;
}

- (void)keyboardWillHide:(NSNotification *)notification
{
    self.keyboardFrame = CGRectZero;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewController:self didChangeChatBoxHeight:HEIGHT_TABBAR];
        _chatBox.status = ICChatBoxStatusNothing;
    }
}

- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    self.keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    if (_chatBox.status == ICChatBoxStatusShowKeyboard && self.keyboardFrame.size.height <= HEIGHT_CHATBOXVIEW) {
        return;
    }
    else if ((_chatBox.status == ICChatBoxStatusShowFace || _chatBox.status == ICChatBoxStatusShowMore) && self.keyboardFrame.size.height <= HEIGHT_CHATBOXVIEW) {
        return;
    }
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        [_delegate chatBoxViewController:self didChangeChatBoxHeight: self.keyboardFrame.size.height + HEIGHT_TABBAR];
        _chatBox.status = ICChatBoxStatusShowKeyboard; // 状态改变
    }
}

// 将要弹出视频视图
- (void)videoViewWillAppear
{
    ICVideoView *videoView = [[ICVideoView alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, videwViewH)];
    [self.view insertSubview:videoView aboveSubview:self.chatBox];
    self.videoView = videoView;
    videoView.hidden = YES;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didVideoViewAppeared:)]) {
        [_delegate chatBoxViewController:self didVideoViewAppeared:videoView];
    }
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark - Getter and Setter

- (ICChatBox *) chatBox
{
    if (_chatBox == nil) {
        _chatBox = [[ICChatBox alloc] initWithFrame:CGRectMake(0, 0, App_Frame_Width, HEIGHT_TABBAR)];
        _chatBox.delegate = self;
    }
    return _chatBox;
}

- (ICChatBoxFaceView *)chatBoxFaceView
{
    if (nil == _chatBoxFaceView) {
        _chatBoxFaceView = [[ICChatBoxFaceView alloc] initWithFrame:CGRectMake(0, HEIGHT_TABBAR, App_Frame_Width, HEIGHT_CHATBOXVIEW)];
    }
    return _chatBoxFaceView;
}

- (ICChatBoxMoreView *)chatBoxMoreView
{
    if (nil == _chatBoxMoreView) {
        _chatBoxMoreView = [[ICChatBoxMoreView alloc] initWithFrame:CGRectMake(0, HEIGHT_TABBAR, App_Frame_Width, HEIGHT_CHATBOXVIEW)];
        _chatBoxMoreView.delegate = self;
        // 创建Item
        ICChatBoxMoreViewItem *photosItem = [ICChatBoxMoreViewItem createChatBoxMoreItemWithTitle:@"照片"
                                 imageName:@"sharemore_pic"];
        ICChatBoxMoreViewItem *takePictureItem = [ICChatBoxMoreViewItem createChatBoxMoreItemWithTitle:@"拍摄"
                                 imageName:@"sharemore_video"];
        ICChatBoxMoreViewItem *videoItem = [ICChatBoxMoreViewItem createChatBoxMoreItemWithTitle:@"小视频"
                                 imageName:@"sharemore_sight"];
        ICChatBoxMoreViewItem *docItem   = [ICChatBoxMoreViewItem createChatBoxMoreItemWithTitle:@"文件" imageName:@"sharemore_wallet"];
        [_chatBoxMoreView setItems:[[NSMutableArray alloc] initWithObjects:photosItem, takePictureItem, videoItem,docItem, nil]];
    }
    return _chatBoxMoreView;
}

- (UIImagePickerController *)imagePicker
{
    if (nil == _imagePicker) {
        _imagePicker = [[UIImagePickerController alloc] init];
        _imagePicker.delegate = self;
        _imagePicker.modalPresentationStyle = UIModalPresentationCustom;
        _imagePicker.view.backgroundColor = [UIColor whiteColor];
        [_imagePicker.navigationBar setBackgroundImage:[UIImage imageNamed:@"daohanglanbeijing"] forBarMetrics:UIBarMetricsDefault];
        _imagePicker.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : [UIColor whiteColor]};
    }
    return _imagePicker;
}

#pragma mark - TLChatBoxMoreViewDelegate

- (void) chatBoxMoreView:(ICChatBoxMoreView *)chatBoxMoreView
           didSelectItem:(ICChatBoxItem)itemType
{
    if (itemType == ICChatBoxItemAlbum) {       // 相册
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            self.imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:self.imagePicker animated:YES completion:nil];
        } else {
            ICLog(@"photLibrary is not available!");
        }
    } else if (itemType == ICChatBoxItemCamera){    // camera
        if (![ICTools hasPermissionToGetCamera]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请在iPhone的“设置-隐私”选项中，允许WeChat访问你的相机。" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                self.imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:self.imagePicker animated:YES completion:nil];
            } else {
                ICLog(@"camera is no available!");
            }
        }
    } else if (itemType == ICChatBoxItemVideo) {
        [self resignFirstResponder];
        if (![[ICVideoManager shareManager] canRecordViedo]) {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请在iPhone的“设置-隐私”选项中，允许WeChat访问你的摄像头和麦克风。" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        } else {
            [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(videoViewWillAppear) userInfo:nil repeats:NO]; // 待动画完成
        }
    } else if (itemType == ICChatBoxItemDoc) {
        ICDocumentViewController *docVC = [[ICDocumentViewController alloc] init];
        docVC.delegate = self;
        XZNavigationController *nav = [[XZNavigationController alloc] initWithRootViewController:docVC];
        [self presentViewController:nav animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
//    NSString *mediaType = info[UIImagePickerControllerMediaType];
//    if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
//        ICLog(@"movie");
//    } else {
        UIImage *orgImage = info[UIImagePickerControllerOriginalImage];
        [picker dismissViewControllerAnimated:YES completion:nil];
        // 图片压缩后再上传服务器
        // 保存路径
        UIImage *simpleImg = [UIImage simpleImage:orgImage];
        NSString *filePaht = [[ICMediaManager sharedManager] saveImage:simpleImg];
        if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:sendImageMessage:imagePath:)]) {
            [_delegate chatBoxViewController:self sendImageMessage:simpleImg imagePath:filePaht];
        }
//    }
}


#pragma mark - ICChatBoxDelegate

/**
 *  输入框状态改变
 *
 *  @param chatBox    chatBox
 *  @param fromStatus 起始状态
 *  @param toStatus   目的状态
 */
- (void)chatBox:(ICChatBox *)chatBox changeStatusForm:(ICChatBoxStatus)fromStatus to:(ICChatBoxStatus)toStatus
{
    if (toStatus == ICChatBoxStatusShowKeyboard) {  // 显示键盘
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.chatBoxFaceView removeFromSuperview];
            [self.chatBoxMoreView removeFromSuperview];
        });
        return;
    } else if (toStatus == ICChatBoxStatusShowVoice) {    // 语音输入按钮
        [UIView animateWithDuration:0.3 animations:^{
            if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                [_delegate chatBoxViewController:self didChangeChatBoxHeight:HEIGHT_TABBAR];
            }
        } completion:^(BOOL finished) {
            [self.chatBoxFaceView removeFromSuperview];
            [self.chatBoxMoreView removeFromSuperview];
        }];
    } else if (toStatus == ICChatBoxStatusShowFace) {     // 表情面板
        if (fromStatus == ICChatBoxStatusShowVoice || fromStatus == ICChatBoxStatusNothing) {
            self.chatBoxFaceView.y = HEIGHT_TABBAR;
            [self.view addSubview:self.chatBoxFaceView];
            [UIView animateWithDuration:0.3 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewController:self didChangeChatBoxHeight:HEIGHT_TABBAR + HEIGHT_CHATBOXVIEW];
                }
            }];
        } else {  // 表情高度变化
            self.chatBoxFaceView.y = HEIGHT_TABBAR + HEIGHT_CHATBOXVIEW;
            [self.view addSubview:self.chatBoxFaceView];
            [UIView animateWithDuration:0.3 animations:^{
                self.chatBoxFaceView.y = HEIGHT_TABBAR;
            } completion:^(BOOL finished) {
                [self.chatBoxMoreView removeFromSuperview];
            }];
            if (fromStatus != ICChatBoxStatusShowMore) {
                [UIView animateWithDuration:0.2 animations:^{
                    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                        [_delegate chatBoxViewController:self didChangeChatBoxHeight:HEIGHT_TABBAR + HEIGHT_CHATBOXVIEW];
                    }
                }];
            }
        }
    } else if (toStatus == ICChatBoxStatusShowMore) {
        if (fromStatus == ICChatBoxStatusShowVoice || fromStatus == ICChatBoxStatusNothing) {
            self.chatBoxMoreView.y = HEIGHT_TABBAR;
            [self.view addSubview:self.chatBoxMoreView];
            [UIView animateWithDuration:0.3 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewController:self didChangeChatBoxHeight:HEIGHT_TABBAR + HEIGHT_CHATBOXVIEW];
                }
            }];
        } else {
            self.chatBoxMoreView.y = HEIGHT_TABBAR + HEIGHT_CHATBOXVIEW;
            [self.view addSubview:self.chatBoxMoreView];
            [UIView animateWithDuration:0.3 animations:^{
                self.chatBoxMoreView.y = HEIGHT_TABBAR;
            } completion:^(BOOL finished) {
                [self.chatBoxFaceView removeFromSuperview];
            }];
            
            [UIView animateWithDuration:0.2 animations:^{
                if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
                    [_delegate chatBoxViewController:self didChangeChatBoxHeight:HEIGHT_TABBAR + HEIGHT_CHATBOXVIEW];
                }
            }];
        }
    }
    
}


- (void)chatBox:(ICChatBox *)chatBox sendTextMessage:(NSString *)textMessage
{
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:sendTextMessage:)]) {
        [_delegate chatBoxViewController:self sendTextMessage:textMessage];
    }
}

/**
 *  输入框高度改变
 *
 *  @param chatBox chatBox
 *  @param height  height
 */
- (void)chatBox:(ICChatBox *)chatBox changeChatBoxHeight:(CGFloat)height
{
    self.chatBoxFaceView.y = height;
    self.chatBoxMoreView.y = height;
    if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:didChangeChatBoxHeight:)]) {
        float h = (self.chatBox.status == ICChatBoxStatusShowFace ? HEIGHT_CHATBOXVIEW : self.keyboardFrame.size.height ) + height;
        [_delegate chatBoxViewController:self didChangeChatBoxHeight: h];
    }

}

- (void)chatBoxDidStartRecordingVoice:(ICChatBox *)chatBox
{
    self.recordName = [self currentRecordFileName];
//    if ([_delegate respondsToSelector:@selector(voiceDidStartRecording)]) {
//        [_delegate voiceDidStartRecording];
//    }
    [[ICRecordManager shareManager] startRecordingWithFileName:self.recordName completion:^(NSError *error) {
        if (error) {   // 加了录音权限的判断
        } else {
            if ([_delegate respondsToSelector:@selector(voiceDidStartRecording)]) {
                [_delegate voiceDidStartRecording];
            }
        }
    }];
}

- (void)chatBoxDidStopRecordingVoice:(ICChatBox *)chatBox
{
    __weak typeof(self) weakSelf = self;
    [[ICRecordManager shareManager] stopRecordingWithCompletion:^(NSString *recordPath) {
        if ([recordPath isEqualToString:shortRecord]) {
            if ([_delegate respondsToSelector:@selector(voiceRecordSoShort)]) {
                [_delegate voiceRecordSoShort];
            }
            [[ICRecordManager shareManager] removeCurrentRecordFile:weakSelf.recordName];
        } else {    // send voice message
            if (_delegate && [_delegate respondsToSelector:@selector(chatBoxViewController:sendVoiceMessage:)]) {
                [_delegate chatBoxViewController:weakSelf sendVoiceMessage:recordPath];
            }
        }
    }];
}
- (void)chatBoxDidCancelRecordingVoice:(ICChatBox *)chatBox
{
    if ([_delegate respondsToSelector:@selector(voiceDidCancelRecording)]) {
        [_delegate voiceDidCancelRecording];
    }
    [[ICRecordManager shareManager] removeCurrentRecordFile:self.recordName];
}

- (void)chatBoxDidDrag:(BOOL)inside
{
    if ([_delegate respondsToSelector:@selector(voiceWillDragout:)]) {
        [_delegate voiceWillDragout:inside];
    }
}


#pragma mark - ICDocumentDelegate

- (void)selectedFileName:(NSString *)fileName
{
    if ([self.delegate respondsToSelector:@selector(chatBoxViewController:sendFileMessage:)]) {
        [self.delegate chatBoxViewController:self sendFileMessage:fileName];
    }
}





@end
