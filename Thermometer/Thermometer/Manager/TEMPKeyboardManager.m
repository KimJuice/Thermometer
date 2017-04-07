//
//  TEMPKeyboardManager.m
//  Thermometer
//
//  Created by milk on 2017/4/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPKeyboardManager.h"

@implementation TEMPKeyboardManager

- (instancetype)initWithNotification:(UIViewController *)controller {

    if (self = [self init]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:controller selector:@selector(keyboardChangeWithNotification:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:controller selector:@selector(keyboardChangeWithNotification:) name:UIKeyboardWillHideNotification object:nil];
    }
    
    return self;
}

+ (void)setupKeyboardHeightwithView:(UIView *)view rect:(CGRect)rect notification:(NSNotification *)notification {

    NSDictionary *userInfo = notification.userInfo;
    NSValue *value = userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    
    CGFloat keyboardH = CGRectGetMinY(keyboardRect);
    CGFloat H = CGRectGetMaxY(rect);
    
    if (keyboardH == view.height) {
        
        [UIView animateWithDuration:0.28 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            view.transform = CGAffineTransformIdentity;
        } completion:nil];
        
        return;
    }
    
    if (keyboardH < H) {
        
        [UIView animateWithDuration:0.28 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            
            view.transform = CGAffineTransformMakeTranslation(view.x, keyboardH - H);
        } completion:nil];
    }
}

@end
