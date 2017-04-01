//
//  TEMPCameraManager.m
//  Thermometer
//
//  Created by milk on 2017/3/31.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPCameraManager.h"
#import <AVFoundation/AVFoundation.h>

#define UILayerY        (SCREEN_HEIGHT - SCREEN_WIDTH) * 0.5
#define UIButtonW       SCREEN_WIDTH * 0.3
#define UIButtonH       SCREEN_HEIGHT * 0.08
// In k units
#define CGIconMaximum   1024

@interface TEMPCameraManager ()

// Camera
@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
@property (nonatomic, strong) AVCaptureStillImageOutput *deviceOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) AVCaptureConnection *connection;

// PhotographBg
@property (nonatomic, strong) UIViewController *controller;
@property (nonatomic, strong) UIView *photographBg;
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, strong) UIButton *photographBtn;

// SetupImageBg
@property (nonatomic, strong) UIView *setupImageBg;
@property (nonatomic, strong) UIButton *retakeBtn;
@property (nonatomic, strong) UIButton *usePhotoBtn;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *coverTop;
@property (nonatomic, strong) UIView *coverBottom;

@end

@implementation TEMPCameraManager

+ (instancetype)shareInstance {
    
    static TEMPCameraManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)buildCameraManager:(UIViewController *)controller {
    
    self.controller = controller;
    UIView *view = controller.view;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Init AVCaptureSession
        self.session = [AVCaptureSession new];
        [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
        
        // Init AVCaptureDeviceInput
        AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
        if (self.deviceInput && [self.session canAddInput:self.deviceInput])
            [self.session addInput:self.deviceInput];
        
        // Init AVCaptureStillImageOutput
        self.deviceOutput = [AVCaptureStillImageOutput new];
        [self.deviceOutput setOutputSettings:@{AVVideoCodecKey:AVVideoCodecJPEG}];
        if ([self.session canAddOutput:self.deviceOutput])
            [self.session addOutput:self.deviceOutput];
        
        // Init UI
        [self setupUI:view];
        
        // Init AVCaptureVideoPreviewLayer
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        self.previewLayer.frame = CGRectMake(0, UILayerY, SCREEN_WIDTH, SCREEN_WIDTH);
        [view.layer addSublayer:self.previewLayer];
        
        // Init AVCaptureConnection
        self.connection = [self.deviceOutput connectionWithMediaType:AVMediaTypeVideo];
        // Video stabilization mode
        self.connection.preferredVideoStabilizationMode = [self.deviceInput.device.activeFormat isVideoStabilizationModeSupported:AVCaptureVideoStabilizationModeCinematic] ? AVCaptureVideoStabilizationModeCinematic : AVCaptureVideoStabilizationModeAuto;
        
        // Start camera
        [self.session startRunning];
    });
}

#pragma mark - ViewMethods

- (void)setupUI:(UIView *)view {
    
    WEAKSELF
    
    // Init photographBg
    self.photographBg = [[UIView alloc] initWithFrame:view.frame];
    self.photographBg.backgroundColor = UIBgBlackColor;
    [view addSubview:self.photographBg];
    
    self.cancelBtn = [UIButton buttonWithText:@"Cancel" textColor:[UIColor whiteColor] textSize:18 horizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    self.cancelBtn.backgroundColor = [UIColor redColor];
    [self.cancelBtn addTarget:self action:@selector(cancelCamera:) forControlEvents:UIControlEventTouchUpInside];
    [self.photographBg addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.photographBg).offset(-20);
        make.left.equalTo(weakSelf.photographBg);
        make.width.mas_equalTo(UIButtonW);
        make.height.mas_equalTo(UIButtonH);
    }];
    
    self.photographBtn = [UIButton buttonWithText:@"Photograph" textColor:[UIColor whiteColor] textSize:18 horizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    self.photographBtn.backgroundColor = [UIColor blueColor];
    [self.photographBtn addTarget:self action:@selector(photograph:) forControlEvents:UIControlEventTouchUpInside];
    [self.photographBg addSubview:self.photographBtn];
    [self.photographBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.photographBg).offset(-20);
        make.left.equalTo(weakSelf.cancelBtn.mas_right);
        make.width.mas_equalTo(UIButtonW);
        make.height.mas_equalTo(UIButtonH);
    }];
    
    // Init setupImageBg
    self.setupImageBg = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.setupImageBg.backgroundColor = self.photographBg.backgroundColor;
    [view addSubview:self.setupImageBg];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, UILayerY, SCREEN_WIDTH, SCREEN_WIDTH)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.backgroundColor = [UIColor yellowColor];
    [self.setupImageBg addSubview:self.imageView];
    
    self.coverTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, UILayerY)];
    self.coverTop.backgroundColor = self.setupImageBg.backgroundColor;
    [self.setupImageBg addSubview:self.coverTop];
    
    self.coverBottom = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - UILayerY, SCREEN_WIDTH, UILayerY)];
    self.coverBottom.backgroundColor = self.setupImageBg.backgroundColor;
    [self.setupImageBg addSubview:self.coverBottom];
    
    self.retakeBtn = [UIButton buttonWithText:@"Retake" textColor:[UIColor whiteColor] textSize:18 horizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    self.retakeBtn.backgroundColor = [UIColor purpleColor];
    [self.retakeBtn addTarget:self action:@selector(retake:) forControlEvents:UIControlEventTouchUpInside];
    [self.coverBottom addSubview:self.retakeBtn];
    [self.retakeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.setupImageBg).offset(-20);
        make.left.equalTo(weakSelf.setupImageBg);
        make.width.mas_equalTo(UIButtonW);
        make.height.mas_equalTo(UIButtonH);
    }];
    
    self.usePhotoBtn = [UIButton buttonWithText:@"Use Photo" textColor:[UIColor whiteColor] textSize:18 horizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    self.usePhotoBtn.backgroundColor = [UIColor grayColor];
    [self.usePhotoBtn addTarget:self action:@selector(usePhoto:) forControlEvents:UIControlEventTouchUpInside];
    [self.coverBottom addSubview:self.usePhotoBtn];
    [self.usePhotoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.setupImageBg).offset(-20);
        make.right.equalTo(weakSelf.setupImageBg);
        make.width.mas_equalTo(UIButtonW);
        make.height.mas_equalTo(UIButtonH);
    }];
}

#pragma mark - ClickEvent

- (void)cancelCamera:(UIButton *)sender {
    
    if ([self.cameraDelegate respondsToSelector:@selector(canclePhotograph)])
        [self.cameraDelegate canclePhotograph];
}

- (void)photograph:(UIButton *)sender {
    
    AVCaptureConnection *connection = [self.deviceOutput connectionWithMediaType:AVMediaTypeVideo];
    if (connection) {
        
        [self.deviceOutput captureStillImageAsynchronouslyFromConnection:connection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
            
            if (!error && imageDataSampleBuffer) {
                
                NSData *imgData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
                UIImage *image = [UIImage imageWithData:imgData];
                self.imageView.image = image;
                [UIView animateWithDuration:0.28 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                    
                    self.photographBg.transform = CGAffineTransformTranslate(self.photographBg.transform, -SCREEN_WIDTH, 0);
                    self.previewLayer.transform = CATransform3DMakeTranslation(-SCREEN_WIDTH, 0, 0);
                    self.setupImageBg.transform = CGAffineTransformTranslate(self.setupImageBg.transform, -SCREEN_WIDTH, 0);
                } completion:nil];
                
            }else {
                
                [UIAlertController alertControllerWithMessage:error ? error.localizedFailureReason : @"Failed to photograph!" controller:self.controller];
            }
        }];
    }else {
        
        [UIAlertController alertControllerWithMessage:@"Failed to get device connection!" controller:self.controller];
    }
}

- (void)retake:(UIButton *)sender {
    
    [UIView animateWithDuration:0.28 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.photographBg.transform = CGAffineTransformIdentity;
        self.previewLayer.transform = CATransform3DIdentity;
        self.setupImageBg.transform = CGAffineTransformIdentity;
    } completion:nil];
}

- (void)usePhoto:(UIButton *)sender {
    
    UIImage *image = [self compressPicture:self.imageView.image];
    
    if ([self.cameraDelegate respondsToSelector:@selector(findPhotograph:)])
        [self.cameraDelegate findPhotograph:image];
    [self cancelCamera:self.cancelBtn];
    [self stopCamera];
}

#pragma mark - FunctionalMethod

- (void)stopCamera {
    
    [self.session stopRunning];
}

- (UIImage *)compressPicture:(UIImage *)image {

    UIImage *compressImage = [UIImage imageWithSize:CGSizeMake(640, 640) sourceImage:image];
    CGFloat quality = 1.1;
    NSData *data;
    
    do {
        
        data = UIImageJPEGRepresentation(compressImage, quality -= 0.1);
    } while (data.length > CGIconMaximum && quality > 0);
    
    data = UIImageJPEGRepresentation(compressImage, quality);
    
    return [UIImage imageWithData:data];
}

@end
