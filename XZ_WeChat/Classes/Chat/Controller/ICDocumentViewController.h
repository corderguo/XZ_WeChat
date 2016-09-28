//
//  ICDocumentViewController.h
//  XZ_WeChat
//
//  Created by 郭现壮 on 16/3/29.
//  Copyright © 2016年 gxz All rights reserved.
//

#import "ICDocumentViewController.h"

@protocol ICDocumentDelegate <NSObject>

- (void)selectedFileName:(NSString *)fileName;

@end

@interface ICDocumentViewController : UIViewController

@property (nonatomic, weak) id <ICDocumentDelegate>delegate;

@end
