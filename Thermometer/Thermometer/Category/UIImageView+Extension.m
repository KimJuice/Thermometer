//
//  UIImageView+Extension.m
//  Thermometer
//
//  Created by milk on 2017/4/6.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)

- (void)setupWithPortrait:(UIImage *)portrait iconSize:(CGSize)iconSize {
    
    portrait = [UIImage imageWithPortrait:portrait borderWidth:30 borderColor:UIFontWhiteColor(0.2).CGColor];
    [self setImage:portrait];
}

@end
