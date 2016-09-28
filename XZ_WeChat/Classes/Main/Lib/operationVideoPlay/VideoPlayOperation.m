//
//  VideoPlayOperation.m
//  VideoPlayer
//
//  Created by eleme on 16/4/26.
//  Copyright © 2016年 zachary. All rights reserved.
//

#import "VideoPlayOperation.h"


@implementation VideoPlayOperation

-(void)videoPlayTask:(NSString *)filePath
{
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:[[NSURL alloc] initFileURLWithPath:filePath] options:nil];
    
    NSError *error;
    AVAssetReader* reader = [[AVAssetReader alloc] initWithAsset:asset error:&error];
    NSArray* videoTracks = [asset tracksWithMediaType:AVMediaTypeVideo];
    
    if (!videoTracks.count) {
        return ;
    }
    
    AVAssetTrack* videoTrack = [videoTracks objectAtIndex:0];
    
    UIImageOrientation orientation = [self orientationFromAVAssetTrack:videoTrack];
    
    int m_pixelFormatType = kCVPixelFormatType_32BGRA;
    NSDictionary* options = [NSDictionary dictionaryWithObject:[NSNumber numberWithInt: (int)m_pixelFormatType] forKey:(id)kCVPixelBufferPixelFormatTypeKey];
    AVAssetReaderTrackOutput* videoReaderOutput = [[AVAssetReaderTrackOutput alloc] initWithTrack:videoTrack outputSettings:options];
    [reader addOutput:videoReaderOutput];
    [reader startReading];
    while ([reader status] == AVAssetReaderStatusReading && videoTrack.nominalFrameRate > 0&&(!self.isCancelled)&&self.videoBlock) {
        CMSampleBufferRef sampleBuffer = [videoReaderOutput copyNextSampleBuffer];
        if (!sampleBuffer) {
            break;
            
        }
        
        UIImage  *img = [VideoPlayOperation imageFromSampleBuffer:sampleBuffer rotation:orientation];
        CGImageRef tpImage = img.CGImage;
        MAIN(^{
            if (self.videoBlock) {
                self.videoBlock(img,filePath,tpImage);
            }
            
            if (sampleBuffer) {
                CFRelease(sampleBuffer);
                
                
            }
            if (tpImage) {
                CGImageRelease(tpImage);
            }
            
        });
        [NSThread sleepForTimeInterval:CMTimeGetSeconds(videoTrack.minFrameDuration)];
    }
    [reader cancelReading];
    
}

- (UIImageOrientation)orientationFromAVAssetTrack:(AVAssetTrack *)videoTrack
{
    UIImageOrientation orientation;
    
    CGAffineTransform t = videoTrack.preferredTransform;
    if(t.a == 0 && t.b == 1.0 && t.c == -1.0 && t.d == 0){
        // Portrait
        //        degress = 90;
        orientation = UIImageOrientationRight;
    }else if(t.a == 0 && t.b == -1.0 && t.c == 1.0 && t.d == 0){
        // PortraitUpsideDown
        //        degress = 270;
        orientation = UIImageOrientationLeft;
    }else if(t.a == 1.0 && t.b == 0 && t.c == 0 && t.d == 1.0){
        // LandscapeRight
        //        degress = 0;
        orientation = UIImageOrientationUp;
    }else if(t.a == -1.0 && t.b == 0 && t.c == 0 && t.d == -1.0){
        // LandscapeLeft
        //        degress = 180;
        orientation = UIImageOrientationDown;
    }
    
    return orientation;
}



+ (UIImage *) imageFromSampleBuffer:(CMSampleBufferRef) sampleBuffer rotation:(UIImageOrientation)orientation{
    CVImageBufferRef imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer);
    // Lock the base address of the pixel buffer
    CVPixelBufferLockBaseAddress(imageBuffer, 0);
    // Get the number of bytes per row for the pixel buffer
    size_t bytesPerRow = CVPixelBufferGetBytesPerRow(imageBuffer);
    // Get the pixel buffer width and height
    size_t width = CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    //Generate image to edit
    unsigned char* pixel = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
    CGColorSpaceRef colorSpace=CGColorSpaceCreateDeviceRGB();
    CGContextRef context=CGBitmapContextCreate(pixel, width, height, 8, bytesPerRow, colorSpace, kCGBitmapByteOrder32Little|kCGImageAlphaPremultipliedFirst);
    CGImageRef image = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    UIGraphicsEndImageContext();
    

    UIImage *img = [UIImage imageWithCGImage:image scale:0 orientation:orientation];
    return img;
}



@end
