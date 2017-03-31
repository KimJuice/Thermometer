//
//  TEMPTabBarController.m
//  Thermometer
//
//  Created by milk on 2017/3/27.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPTabBarController.h"
#import "TEMPMeasureController.h"
#import "TEMPChartController.h"

@interface TEMPTabBarController ()

@end

@implementation TEMPTabBarController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self setupUI];
}

- (void)setupUI {
    
    self.tabBar.backgroundImage = [UIImage imageWithColor:UIColorRGBNoAlpha(53, 58, 64)];
    [self.tabBar setTintColor:[UIColor colorWithWhite:1.0 alpha:0.9]];
    [self.tabBar setUnselectedItemTintColor:[UIColor colorWithWhite:1.0 alpha:0.5]];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys: [UIFont systemFontOfSize:14], NSFontAttributeName, nil] forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitlePositionAdjustment:UIOffsetMake(0, -15)];

    [self addChildViewController:[TEMPMeasureController new] title:@"Measure" imageName:ICON_Tabbar_home];
    [self addChildViewController:[TEMPChartController new] title:@"Chart" imageName:ICON_Tabbar_chart];
}

- (void)addChildViewController:(UIViewController *)controller title:(NSString *)title imageName:(NSString *)imageName {

    controller.title = title;
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
