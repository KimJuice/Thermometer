//
//  UIAlertAction+Extension.h
//  Thermometer
//
//  Created by milk on 2017/3/29.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertAction (Extension)

+ (instancetype)actionWithTitle:(NSString *)title style:(UIAlertActionStyle)style handler:(void (^)(UIAlertAction *action))handler titleColor:(UIColor *)titleColor;

@end
