//
//  TEMPTextField.m
//  Thermometer
//
//  Created by milk on 2017/3/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPTextField.h"

#define kBorderWidth 0.6

@implementation TEMPTextField

- (instancetype)initWithSubjectColor:(UIColor *)subjectColor bgColor:(UIColor *)bgColor clearButtonImage:(UIImage *)clearButtonImage {

    if (self = [super init]) {
        
        self.subjectColor = subjectColor;
        self.bgColor = bgColor;
        self.clearButtonImage = clearButtonImage;
        
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
        if (clearButtonImage) {
            
            UIButton *defaultClearButton = [UIButton appearanceWhenContainedInInstancesOfClasses:@[[UITextField class]]];
            [defaultClearButton setBackgroundImage:clearButtonImage forState:UIControlStateSelected];
        }
        self.font = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        self.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
        self.borderStyle = UITextBorderStyleRoundedRect;
        self.tintColor = subjectColor;
    }
    
    return self;
}

- (instancetype)initWithLineType:(CGSize)size subjectColor:(UIColor *)subjectColor clearButtonImage:(UIImage *)clearButtonImage placeholder:(NSString *)placeholder isSecureEntry:(BOOL)isSecureEntry {

    if (self = [super init]) {
        
        self.subjectColor = subjectColor;
        self.clearButtonImage = clearButtonImage;
        
        if (clearButtonImage) {
            
            self.clearButtonMode = UITextFieldViewModeWhileEditing;
            UIButton *defaultClearButton = [UIButton appearanceWhenContainedInInstancesOfClasses:@[[UITextField class]]];
            [defaultClearButton setBackgroundImage:clearButtonImage forState:UIControlStateNormal];
        }
        
        if (isSecureEntry) {
            
            self.secureTextEntry = isSecureEntry;
            UIButton *rightBtn = [self addSecureTextEntryBtn];
            [rightBtn addTarget:self action:@selector(clickSecureTextEntryBtn:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeholder attributes:@{ NSForegroundColorAttributeName : subjectColor, NSFontAttributeName: [UIFont systemFontOfSize:12] }];        
        self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.font = [UIFont systemFontOfSize:12];
        self.tintColor = subjectColor;
        self.textColor = subjectColor;
        CALayer *layer = [CALayer new];
        layer.borderWidth = kBorderWidth;
        layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.3].CGColor;
        layer.frame = CGRectMake(0, size.height - kBorderWidth, size.width, kBorderWidth);
        [self.layer addSublayer:layer];
    }
    
    return self;
}

- (UIButton *)addSecureTextEntryBtn {
    
    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(-40, 0, 25, 25)];
    [rightBtn setBackgroundImage:UIImageNamed(ICON_Field_secureEntry_YES) forState:UIControlStateNormal];
    [rightBtn setBackgroundImage:UIImageNamed(ICON_Field_secureEntry_NO) forState:UIControlStateSelected];
    self.rightView = rightBtn;
    self.rightViewMode = UITextFieldViewModeWhileEditing;
    
    return rightBtn;
}

- (void)clickSecureTextEntryBtn:(UIButton *)sender {
    
    self.secureTextEntry = sender.selected;
    sender.selected = !sender.selected;
}

@end
