//
//  TEMPCameraController.h
//  Thermometer
//
//  Created by milk on 2017/3/31.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TEMPCameraManager.h"

@protocol TEMPCameraControllerDelegate <NSObject>

- (void)findPhotographWithImage:(UIImage *)image;

@end

@interface TEMPCameraController : UIViewController

@property (nonatomic, assign) id <TEMPCameraControllerDelegate>cameraDelegate;

@end
