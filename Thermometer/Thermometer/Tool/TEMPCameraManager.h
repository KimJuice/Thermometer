//
//  TEMPCameraManager.h
//  Thermometer
//
//  Created by milk on 2017/3/31.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEMPCameraManagerDelegate <NSObject>

- (void)canclePhotograph;
- (void)findPhotograph:(UIImage *)image;

@end

@interface TEMPCameraManager : NSObject

@property (nonatomic, assign) id <TEMPCameraManagerDelegate>cameraDelegate;

+ (instancetype)shareInstance;
- (void)buildCameraManager:(UIViewController *)controller;

@end
