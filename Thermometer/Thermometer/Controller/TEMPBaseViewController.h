//
//  TEMPBaseViewController.h
//  Thermometer
//
//  Created by milk on 2017/3/28.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TEMPBaseViewController : UIViewController

@property (nonatomic, strong) UIImageView *bgImageView;

- (instancetype)initWithIsNotNavBarHidden:(BOOL)isNotNavBarHidden;

@end
