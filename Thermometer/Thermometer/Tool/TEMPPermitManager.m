//
//  TEMPPermitManager.m
//  Thermometer
//
//  Created by milk on 2017/3/29.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPPermitManager.h"
#import <Photos/Photos.h>

@implementation TEMPPermitManager

+ (void)permitWithCamera:(UIViewController *)controller {
    
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    
    if (status != AVAuthorizationStatusAuthorized) {
        
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            
            if (!granted) {
                
                UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:AVCameraPermit preferredStyle:UIAlertControllerStyleAlert];
                
                UIAlertAction *setupAction = [UIAlertAction actionWithTitle:@"Setup" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                } titleColor:UIFontBlackColor];
                
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {} titleColor:[[UIColor redColor] colorWithAlphaComponent:0.8]];
                
                [alert addAction:cancelAction];
                [alert addAction:setupAction];
                [controller presentViewController:alert animated:YES completion:nil];
            }
        }];
    }
}

@end
