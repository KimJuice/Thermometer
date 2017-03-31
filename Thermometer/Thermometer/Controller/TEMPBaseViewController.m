//
//  TEMPBaseViewController.m
//  Thermometer
//
//  Created by milk on 2017/3/28.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPBaseViewController.h"

@interface TEMPBaseViewController ()

@property (nonatomic, assign) BOOL isNotNavBarHidden;

@end

@implementation TEMPBaseViewController

- (instancetype)initWithIsNotNavBarHidden:(BOOL)isNotNavBarHidden {
    
    self = [super init];
    if (self) {
        
        self.isNotNavBarHidden = isNotNavBarHidden;
    }
    
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.bgImageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    self.bgImageView.image = UIImageNamed(ICON_BG2);
    self.bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.bgImageView];

    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:!self.isNotNavBarHidden];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
