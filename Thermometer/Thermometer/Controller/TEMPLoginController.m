//
//  TEMPLoginController.m
//  Thermometer
//
//  Created by milk on 2017/3/20.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPLoginController.h"
#import "TEMPTextField.h"
#import "TEMPTabBarController.h"
#import "TEMPPermitManager.h"
#import "TEMPEditImageController.h"
#import "TEMPCameraController.h"

#define kBoxHeight 25
#define kBoxWidth SCREEN_WIDTH * 0.8

@interface TEMPLoginController () <UITextFieldDelegate>

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) TEMPTextField *userNameField;
@property (nonatomic, strong) UILabel *passWordLabel;
@property (nonatomic, strong) TEMPTextField *passWordField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgotKeyBtn;
@property (nonatomic, strong) UIButton *signUpBtn;

@end

@implementation TEMPLoginController

#pragma mark - ViewMethods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    
    SETBACKGROUNDCOLOR(UIBgBlackColor)
    self.bgImageView.image = UIImageNamed(ICON_BG_Login);
    
    WEAKSELF
    
    self.iconView = [UIImageView new];
    [self.iconView setupWithPortrait:UIImageNamed(ICON_Default_Portrait) iconSize:CGICONSIZE];
    [self.view addSubview:self.iconView];
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(SCREEN_HEIGHT * 0.16);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGICONSIZE);
    }];
    
    self.userNameLabel = [UILabel new];
    self.userNameLabel.textColor = UIFontWhiteColor(0.5);
    self.userNameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    self.userNameLabel.text = @"USERNAME";
    [self.view addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconView.mas_bottom).offset(SCREEN_HEIGHT * 0.16 - 20);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(22);
    }];
    
    self.userNameField = [[TEMPTextField alloc] initWithLineType:CGSizeMake(kBoxWidth, kBoxHeight) subjectColor:UIFontWhiteColor(0.9) clearButtonImage:UIImageNamed(ICON_Button_Field_delete1) placeholder:@"Username / Email Address" isSecureEntry:NO];
    self.userNameField.delegate = self;
    [self.view addSubview:self.userNameField];
    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(6);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(kBoxHeight);
    }];
    
    self.passWordLabel = [UILabel new];
    self.passWordLabel.textColor = UIFontWhiteColor(0.5);
    self.passWordLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    self.passWordLabel.text = @"PASSWORD";
    [self.view addSubview:self.passWordLabel];
    [self.passWordLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNameField.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(22);
    }];
    
    self.passWordField = [[TEMPTextField alloc] initWithLineType:CGSizeMake(kBoxWidth, kBoxHeight) subjectColor:UIFontWhiteColor(0.9) clearButtonImage:nil placeholder:@"••••••" isSecureEntry:YES];
    self.passWordField.delegate = self;
    [self.view addSubview:self.passWordField];
    [self.passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passWordLabel.mas_bottom).offset(6);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(kBoxHeight);
    }];
    
    self.loginBtn = [UIButton new];
    self.loginBtn.backgroundColor = [UIColor whiteColor];
    [self.loginBtn setTitle:@"Sign in" forState:UIControlStateNormal];
    [self.loginBtn setTitleColor:UIFontBlackColor forState:UIControlStateNormal];
    [self.loginBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:0.2]] forState:UIControlStateHighlighted];
    [self.loginBtn addTarget:self action:@selector(clickLoginBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.loginBtn];
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passWordField.mas_bottom).offset(30);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(40);
    }];
    
    CGFloat width = kBoxWidth * 0.5 - 20 - 0.5;
    
    self.forgotKeyBtn = [UIButton buttonWithText:@"Forgot password" textColor:[UIColor whiteColor] textSize:12 horizontalAlignment:UIControlContentHorizontalAlignmentRight];
    [self.forgotKeyBtn addTarget:self action:@selector(retrievePassword:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.forgotKeyBtn];
    [self.forgotKeyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loginBtn.mas_bottom);
        make.left.equalTo(weakSelf.loginBtn);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(40);
    }];
    
    UIView *line = [UIView new];
    line.backgroundColor = UIFontWhiteColor(0.9);
    [self.view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf.forgotKeyBtn);
        make.left.equalTo(weakSelf.forgotKeyBtn.mas_right).offset(20);
        make.width.mas_equalTo(1);
        make.height.mas_equalTo(15);
    }];
    
    self.signUpBtn = [UIButton buttonWithText:@"Sign up" textColor:[UIColor whiteColor] textSize:12 horizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [self.signUpBtn addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpBtn];
    [self.signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.loginBtn.mas_bottom);
        make.left.equalTo(line.mas_right).offset(20);
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(40);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.userNameField resignFirstResponder];
    [self.passWordField resignFirstResponder];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ClickEvent

- (void)clickLoginBtn:(UIButton *)sender {
    
    [[TEMPSqlData sharedInstance] creatQueue];
    
    [self.navigationController pushViewController:[TEMPTabBarController new] animated:YES];
}

- (void)retrievePassword:(UIButton *)sender {

    NSLog(@"%s",__FUNCTION__);
}

- (void)signUp:(UIButton *)sender {

    NSLog(@"%s",__FUNCTION__);
}

@end
