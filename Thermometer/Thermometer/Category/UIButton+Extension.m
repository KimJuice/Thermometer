//
//  UIButton+Extension.m
//  Thermometer
//
//  Created by milk on 2017/3/24.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "UIButton+Extension.h"

@implementation UIButton (Extension)

+ (UIButton *)buttonWithText:(NSString *)title textColor:(UIColor *)textColor textSize:(CGFloat)textSize horizontalAlignment:(UIControlContentHorizontalAlignment)horizontalAlignment {

    UIButton *btn = [UIButton new];
    [btn setContentHorizontalAlignment:horizontalAlignment];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:textSize]];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[textColor colorWithAlphaComponent:0.9] forState:UIControlStateNormal];
    [btn setTitleColor:[textColor colorWithAlphaComponent:0.6] forState:UIControlStateHighlighted];

    return btn;
}

- (void)setupWithPortrait:(UIImage *)portrait iconSize:(CGSize)iconSize {

    portrait = [UIImage imageWithPortrait:portrait borderWidth:30 borderColor:UIFontWhiteColor(0.2).CGColor];
    [self setBackgroundImage:portrait forState:UIControlStateNormal];
}

@end
