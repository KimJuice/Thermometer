//
//  UIAlertAction+Extension.m
//  Thermometer
//
//  Created by milk on 2017/3/29.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "UIAlertAction+Extension.h"

@implementation UIAlertAction (Extension)

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *))handler titleColor:(UIColor *)titleColor {

    UIAlertAction *action = [UIAlertAction actionWithTitle:title style:style handler:^(UIAlertAction * _Nonnull action) {
        
        if (handler) handler(action);
    }];
    
    [action setValue:titleColor forKey:@"titleTextColor"];
    return action;
}

@end
