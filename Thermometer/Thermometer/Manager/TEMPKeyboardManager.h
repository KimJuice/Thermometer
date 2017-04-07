//
//  TEMPKeyboardManager.h
//  Thermometer
//
//  Created by milk on 2017/4/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TEMPKeyboardManagerDelegate <NSObject>

///** 必须实现该方法 **///
- (void)keyboardChangeWithNotification:(NSNotification *)notification;

@end

@interface TEMPKeyboardManager : NSObject

@property (nonatomic, assign) id <TEMPKeyboardManagerDelegate>keyboardDelegate;

- (instancetype)initWithNotification:(UIViewController *)controller;

/**
 根据键盘高度设置View高度

 @param view   想要移动的基视图
 @param rect   光标所在控件的rect
 @param notification 键盘的通知
 */
+ (void)setupKeyboardHeightwithView:(UIView *)view rect:(CGRect)rect notification:(NSNotification *)notification;

@end
