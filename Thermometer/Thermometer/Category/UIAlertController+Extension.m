//
//  UIAlertController+Extension.m
//  Thermometer
//
//  Created by milk on 2017/3/30.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "UIAlertController+Extension.h"

@implementation UIAlertController (Extension)

+ (void)alertControllerWithMessage:(NSString *)message controller:(UIViewController *)controller {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Tips" message:message preferredStyle:UIAlertControllerStyleAlert];
    [controller presentViewController:alert animated:YES completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [alert dismissViewControllerAnimated:YES completion:nil];
    });
}

@end
