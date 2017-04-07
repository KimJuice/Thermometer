//
//  UIView+Extension.m
//  Thermometer
//
//  Created by milk on 2017/4/1.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (CGPoint)origin {

    return self.frame.origin;
}

- (CGFloat)x {
    
    return self.origin.x;
}

- (CGFloat)y {

    return self.origin.y;
}

- (CGSize)size {
    
    return self.frame.size;
}

- (CGFloat)width {

    return self.size.width;
}

- (CGFloat)height {

    return self.size.height;
}

@end
