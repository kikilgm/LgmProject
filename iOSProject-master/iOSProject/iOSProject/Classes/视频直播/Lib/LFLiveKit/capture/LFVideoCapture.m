//
//  LFVideoCapture.m
//  LFLiveKit
//
//  Created by 倾慕 on 16/5/1.
//  Copyright © 2016年 倾慕. All rights reserved.
//

#import "LFVideoCapture.h"
#import "GPUImage.h"
#import "LFGPUImageBeautyFilter.h"
#import "LFGPUImageEmptyFilter.h"

@interface LFVideoCapture ()

@property(nonatomic, strong) GPUImageVideoCamera *videoCamera;
@property(nonatomic, strong) GPUImageOutput<GPUImageInput> *filter;
@property(nonatomic, strong) GPUImageOutput<GPUImageInput> *emptyFilter;
@property(nonatomic, strong) GPUImageOutput<GPUImageInput> *beau;
@property(nonatomic, strong) GPUImageCropFilter *cropfilter;
@property(nonatomic, strong) GPUImageView *gpuImageView;
@property (nonatomic, strong) LFLiveVideoConfiguration *configuration;

@end

@implementation LFVideoCapture

#pragma mark -- LifeCycle
- (instancetype)initWithVideoConfiguration:(LFLiveVideoConfiguration *)configuration{
    if(self = [super init]){
        _configuration = configuration;
        _videoCamera = [[GPUImageVideoCamera alloc] initWithSessionPreset:_configuration.avSessionPreset cameraPosition:AVCaptureDevicePositionFront];
        _videoCamera.outputImageOrientation = _configuration.orientation;
        _videoCamera.horizontallyMirrorFrontFacingCamera = YES;
        _videoCamera.horizontallyMirrorRearFacingCamera = NO;
        _videoCamera.frameRate = (int32_t)_configuration.videoFrameRate;
        
        _gpuImageView = [[GPUImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_gpuImageView setFillMode:kGPUImageFillModePreserveAspectRatioAndFill];
        [_gpuImageView setAutoresizingMask:UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterBackground:) name:UIApplicationWillResignActiveNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterForeground:) name:UIApplicationDidBecomeActiveNotification object:nil];
        
        self.beautyFace = YES;
    }
    return self;
}

- (void)dealloc{
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_videoCamera stopCameraCapture];
}

#pragma mark -- Setter Getter
- (void)setRunning:(BOOL)running{
    if(_running == running) return;
    _running = running;
    
    if(!_running){
        [UIApplication sharedApplication].idleTimerDisabled = NO;
        [_videoCamera stopCameraCapture];
    }else{
        [UIApplication sharedApplication].idleTimerDisabled = YES;
        [_videoCamera startCameraCapture];
    }
}

- (void)setPreView:(UIView *)preView{
    if(_gpuImageView.superview) [_gpuImageView removeFromSuperview];
    [preView insertSubview:_gpuImageView atIndex:0];
}

- (UIView*)preView{
    return _gpuImageView.superview;
}

- (void)setCaptureDevicePosition:(AVCaptureDevicePosition)captureDevicePosition{
    [_videoCamera rotateCamera];
    _videoCamera.frameRate = (int32_t)_configuration.videoFrameRate;
}

- (AVCaptureDevicePosition)captureDevicePosition{
    return [_videoCamera cameraPosition];
}

- (void)setVideoFrameRate:(NSInteger)videoFrameRate{
    if(videoFrameRate <= 0) return;
    if(videoFrameRate == _videoCamera.frameRate) return;
    _videoCamera.frameRate = (uint32_t)videoFrameRate;
}

- (NSInteger)videoFrameRate{
    return _videoCamera.frameRate;
}

- (void)setBeautyFace:(BOOL)beautyFace{
    if(_beautyFace == beautyFace) return;
    
    _beautyFace = beautyFace;
    [_emptyFilter removeAllTargets];
    [_filter removeAllTargets];
    [_cropfilter removeAllTargets];
    [_videoCamera removeAllTargets];
    [_beau removeAllTargets];
    
    //    [_cropfilter1 removeAllTargets];
    //    [_scale removeAllTargets];
    
    if(_beautyFace){
        //_filter = [[LFGPUImageBeautyFilter alloc] init];
        //        _scale = [[GPUImageTransformFilter alloc] init];
        //        [(GPUImageTransformFilter*)_scale setAffineTransform:CGAffineTransformMakeScale(0.5, 0.5)];
        //        _cropfilter1 = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.25, 0.25, 0.5, 0.5)];
        
        _filter = [[GPUImageUnsharpMaskFilter alloc] init];
        //[(GPUImageUnsharpMaskFilter*)_filter setIntensity:1.35];
        [(GPUImageUnsharpMaskFilter*)_filter setIntensity:1.23];
        [(GPUImageUnsharpMaskFilter*)_filter setBlurRadiusInPixels:13];
        _beau = [[LFGPUImageBeautyFilter alloc] init];
        //CGFloat radiusInPixels = _configuration.isClipVideo ? 9 : 13;//////< 360  540 720 :////  9   9   13
        //[(LFGPUImageBeautyFilter*)_filter setBlurRadiusInPixels:radiusInPixels];
        _emptyFilter = [[LFGPUImageEmptyFilter alloc] init];
        //[(GPUImageUnsharpMaskFilter*)_emptyFilter setIntensity:1.01];
        //[(GPUImageUnsharpMaskFilter*)_emptyFilter setBlurRadiusInPixels:7];
    }else{
        _filter = [[LFGPUImageEmptyFilter alloc] init];
        //        _filter = [[GPUImageTransformFilter alloc] init];
        //        [(GPUImageTransformFilter*)_filter setAffineTransform:CGAffineTransformMakeScale(0.5, 0.5)];
        //        _cropfilter1 = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.25, 0.25, 0.5, 0.5)];
    }
    
    
    
    if (beautyFace) {
        __weak typeof(self) _self = self;
        //[_filter forceProcessingAtSize:_configuration.videoSize];
        [_emptyFilter setFrameProcessingCompletionBlock:^(GPUImageOutput *output, CMTime time) {
            [_self processVideo:output];
        }];
    } else {
        __weak typeof(self) _self = self;
        //[_filter forceProcessingAtSize:_configuration.videoSize];
        [_filter setFrameProcessingCompletionBlock:^(GPUImageOutput *output, CMTime time) {
            [_self processVideo:output];
        }];
    }
    
    
    if(_configuration.isClipVideo){
        if(_configuration.orientation == UIInterfaceOrientationPortrait || _configuration.orientation == UIInterfaceOrientationPortraitUpsideDown){
            _cropfilter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0.125, 0, 0.75, 1)];
        }else{
            _cropfilter = [[GPUImageCropFilter alloc] initWithCropRegion:CGRectMake(0, 0.125, 1, 0.75)];
        }
        [_videoCamera addTarget:_cropfilter];
        [_cropfilter addTarget:_filter];
    }else{
        [_videoCamera addTarget:_filter];
        
    }
    
    if (beautyFace) {
        //        [_videoCamera addTarget:_scale];
        //        [_scale addTarget:_cropfilter1];
        //        [_cropfilter1 addTarget:_filter];
        
        [_filter addTarget:_beau];
        [_beau addTarget:_emptyFilter];
        [_emptyFilter addTarget:_gpuImageView];
    } else {
        //        [_videoCamera addTarget:_filter];
        //        [_filter addTarget:_cropfilter1];
        //        [_cropfilter1 addTarget:_gpuImageView];
        [_filter addTarget:_gpuImageView];
    }
    
}

#pragma mark -- Custom Method
- (void) processVideo:(GPUImageOutput *)output{
    __weak typeof(self) _self = self;
    @autoreleasepool {
        GPUImageFramebuffer *imageFramebuffer = output.framebufferForOutput;
        //CVPixelBufferRef pixelBuffer = [imageFramebuffer pixelBuffer];
        
        size_t width = imageFramebuffer.size.width;
        size_t height = imageFramebuffer.size.height;
        ///< 这里可能会影响性能，以后要尝试修改GPUImage源码 直接获取CVPixelBufferRef 目前是获取的bytes 其实更麻烦了
        if(imageFramebuffer.size.width == 360){
            width = 368;///< 必须被16整除
        }
        
        CVPixelBufferRef pixelBuffer = NULL;
        CVPixelBufferCreateWithBytes(kCFAllocatorDefault, width, height, kCVPixelFormatType_32BGRA, [imageFramebuffer byteBuffer], width * 4, nil, NULL, NULL, &pixelBuffer);

        if(pixelBuffer && _self.delegate && [_self.delegate respondsToSelector:@selector(captureOutput:pixelBuffer:)]){
            [_self.delegate captureOutput:_self pixelBuffer:pixelBuffer];
        }
        CVPixelBufferRelease(pixelBuffer);

    }
}

#pragma mark Notification

- (void)willEnterBackground:(NSNotification*)notification{
    [UIApplication sharedApplication].idleTimerDisabled = NO;
    [_videoCamera pauseCameraCapture];
    runSynchronouslyOnVideoProcessingQueue(^{
        glFinish();
    });
}

- (void)willEnterForeground:(NSNotification*)notification{
    [_videoCamera resumeCameraCapture];
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

@end
