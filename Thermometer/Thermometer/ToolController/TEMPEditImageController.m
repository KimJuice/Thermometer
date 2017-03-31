//
//  TEMPEditImageController.m
//  Thermometer
//
//  Created by milk on 2017/3/30.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPEditImageController.h"

@interface TEMPEditImageController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation TEMPEditImageController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setupUI {

    SETBACKGROUNDCOLOR(UIBgBlackColor)
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.frame];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)prefersStatusBarHidden {

    return YES;
}

@end
