//
//  UIImage+Extension.m
//  Thermometer
//
//  Created by milk on 2017/3/8.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

- (CGFloat)width {
    
    return self.size.width;
}

- (CGFloat)height {
    
    return self.size.height;
}

+ (UIImage *)imageWithColor:(UIColor *)color {

    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithRect:(CGRect)rect sourceImage:(UIImage *)sourceImage {

    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextStrokeRect(context, rect);
    [sourceImage drawInRect:rect];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)imageWithPortrait:(UIImage *)sourceImage borderWidth:(CGFloat)borderWidth borderColor:(CGColorRef)borderColor {

    CGSize contextSize = CGSizeMake(sourceImage.width + 2 * borderWidth, sourceImage.height + 2 * borderWidth);
    UIGraphicsBeginImageContextWithOptions(contextSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGPoint imageCenter = CGPointMake(contextSize.width * 0.5, contextSize.height * 0.5);
    CGFloat radius = (contextSize.width - borderWidth) * 0.5;
    CGContextAddArc(context, imageCenter.x, imageCenter.y, radius, 0, 2 * M_PI, 1);
    CGContextSetLineWidth(context, borderWidth);
    CGContextSetStrokeColorWithColor(context, borderColor);
    CGContextStrokePath(context);
    
    CGContextAddArc(context, imageCenter.x, imageCenter.y, sourceImage.width * 0.5, 0, 2 * M_PI, 1);
    CGContextClip(context);
    
    [sourceImage drawAtPoint:CGPointMake(borderWidth, borderWidth)];
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
