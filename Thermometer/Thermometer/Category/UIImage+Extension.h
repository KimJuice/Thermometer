//
//  UIImage+Extension.h
//  Thermometer
//
//  Created by milk on 2017/3/8.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

- (CGFloat)width;
- (CGFloat)height;

+ (UIImage *)imageWithColor:(UIColor *)color;
+ (UIImage *)imageWithRect:(CGRect)rect sourceImage:(UIImage *)sourceImage;
+ (UIImage *)imageWithPortrait:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor;

@end
