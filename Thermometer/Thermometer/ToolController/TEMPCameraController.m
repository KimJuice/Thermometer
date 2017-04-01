//
//  TEMPCameraController.m
//  Thermometer
//
//  Created by milk on 2017/3/31.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPCameraController.h"

@interface TEMPCameraController () <TEMPCameraManagerDelegate>

@property (nonatomic, strong) TEMPCameraManager *cameraManager;

@end

@implementation TEMPCameraController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    SETBACKGROUNDCOLOR(UIBgBlackColor);
    self.cameraManager = [TEMPCameraManager shareInstance];
    [self.cameraManager buildCameraManager:self];
    self.cameraManager.cameraDelegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

#pragma mark - TEMPCameraManagerDelegate

- (void)canclePhotograph {

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)findPhotograph:(UIImage *)image {

    if ([self.cameraDelegate respondsToSelector:@selector(findPhotographWithImage:)])
        [self.cameraDelegate findPhotographWithImage:image];
}

@end
