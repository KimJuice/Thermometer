//
//  UIView+Extension.m
//  Thermometer
//
//  Created by milk on 2017/3/30.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

+ (UIView *)initWithCameraOverlayView:(BOOL)isCamera {

    CGFloat viewY = isCamera ? SCREEN_HEIGHT * 0.05 : 0;
    CGFloat viewH = isCamera ? SCREEN_HEIGHT * 0.77 : SCREEN_HEIGHT * 0.97;
    CGFloat marginH = (viewH - SCREEN_WIDTH) * 0.5;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, viewY, SCREEN_WIDTH, viewH)];
    view.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.6];
    
    UIView *topView = [UIView new];
    topView.backgroundColor = [UIColor blackColor];
    [view addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view);
        make.centerX.equalTo(view);
        make.width.equalTo(view);
        make.height.mas_equalTo(marginH);
    }];
    
    UIView *bottomView = [UIView new];
    bottomView.backgroundColor = isCamera ? [UIColor blueColor] : [[UIColor redColor] colorWithAlphaComponent:0.6];
    [view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(view);
        make.centerX.equalTo(view);
        make.width.equalTo(view);
        make.height.mas_equalTo(marginH);
    }];
    
    return view;
}

@end
