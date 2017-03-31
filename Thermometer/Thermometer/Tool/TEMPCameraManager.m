//
//  TEMPCameraManager.m
//  Thermometer
//
//  Created by milk on 2017/3/31.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPCameraManager.h"
#import <AVFoundation/AVFoundation.h>

#define UILayerY (SCREEN_HEIGHT - SCREEN_WIDTH) * 0.5
#define UIButtonW SCREEN_WIDTH * 0.3
#define UIButtonH SCREEN_HEIGHT * 0.08

@interface TEMPCameraManager ()

// 会话
@property (nonatomic, strong) AVCaptureSession *session;
// 设备输入
@property (nonatomic, strong) AVCaptureDeviceInput *deviceInput;
// 设备输出
@property (nonatomic, strong) AVCaptureVideoDataOutput *deviceOutput;
// 预览
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
// 连接
@property (nonatomic, strong) AVCaptureConnection *connection;

@property (nonatomic, strong) UIButton *cancelBtn;

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

- (void)buildCameraManager:(UIView *)view {
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        // Init AVCaptureSession
        self.session = [AVCaptureSession new];
        [self.session setSessionPreset:AVCaptureSessionPresetPhoto];
        
        // Init AVCaptureDeviceInput
        AVCaptureDevice *videoDevice = [AVCaptureDevice defaultDeviceWithDeviceType:AVCaptureDeviceTypeBuiltInWideAngleCamera mediaType:AVMediaTypeVideo position:AVCaptureDevicePositionBack];
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:nil];
        if (self.deviceInput && [self.session canAddInput:self.deviceInput])
            [self.session addInput:self.deviceInput];
        
        // Init AVCaptureVideoDataOutput
        self.deviceOutput = [AVCaptureVideoDataOutput new];
        if ([self.session canAddOutput:self.deviceOutput])
            [self.session addOutput:self.deviceOutput];
        
        // Init AVCaptureVideoPreviewLayer
        self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
        [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
        self.previewLayer.frame = CGRectMake(0, UILayerY, SCREEN_WIDTH, SCREEN_WIDTH);
        [view.layer addSublayer:self.previewLayer];
        
        // Init AVCaptureConnection
        self.connection = [self.deviceOutput connectionWithMediaType:AVMediaTypeVideo];
        // Video stabilization mode
        self.connection.preferredVideoStabilizationMode = [self.deviceInput.device.activeFormat isVideoStabilizationModeSupported:AVCaptureVideoStabilizationModeCinematic] ? AVCaptureVideoStabilizationModeCinematic : AVCaptureVideoStabilizationModeAuto;
        
        // Init UI
        [self setupUI:view];
        
        // Start camera
        [self.session startRunning];
    });
}

- (void)setupUI:(UIView *)view {

    self.cancelBtn = [UIButton buttonWithText:@"Cancel" textColor:[UIColor whiteColor] textSize:18 horizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    self.cancelBtn.backgroundColor = [UIColor redColor];
    [self.cancelBtn addTarget:self action:@selector(cancelCamera:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view).offset(-20);
        make.left.equalTo(view);
        make.width.mas_equalTo(UIButtonW);
        make.height.mas_equalTo(UIButtonH);
    }];
}

- (void)cancelCamera:(UIButton *)sender {

    if ([self.cameraDelegate respondsToSelector:@selector(canclePhotograph)])
        [self.cameraDelegate canclePhotograph];
}

- (void)stopCamera {

    [self.session stopRunning];
}

@end
