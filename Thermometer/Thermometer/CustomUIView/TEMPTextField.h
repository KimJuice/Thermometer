//
//  TEMPTextField.h
//  Thermometer
//
//  Created by milk on 2017/3/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEMPTextField : UITextField <UITextFieldDelegate>

@property (nonatomic, strong) UIColor *subjectColor;
@property (nonatomic, strong) UIColor *bgColor;
@property (nonatomic, strong) UIImage *clearButtonImage;

- (instancetype)initWithSubjectColor:(UIColor *)subjectColor bgColor:(UIColor *)bgColor clearButtonImage:(UIImage *)clearButtonImage;
- (instancetype)initWithLineType:(CGSize)size subjectColor:(UIColor *)subjectColor clearButtonImage:(UIImage *)clearButtonImage placeholder:(NSString *)placeholder isSecureEntry:(BOOL)isSecureEntry;

@end
