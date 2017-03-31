//
//  ViewController.m
//  Thermometer
//
//  Created by milk on 2017/3/3.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPMeasureController.h"
#import "TEMPTextField.h"
#import "TEMPChartController.h"

@interface TEMPMeasureController () <UITextFieldDelegate>

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UILabel *promptLabel;
@property (nonatomic, strong) TEMPTextField *inputField;
@property (nonatomic, strong) UILabel *unitLabel;
@property (nonatomic, strong) UIButton *chartButton;

@end

@implementation TEMPMeasureController

#pragma mark - 懒加载

- (UILabel *)promptLabel {

    if (!_promptLabel) {
        _promptLabel = [UILabel new];
    }
    return _promptLabel;
}

- (TEMPTextField *)inputField {

    if (!_inputField) {
        _inputField = [[TEMPTextField alloc] initWithSubjectColor:UIButtonPinkColor(1.0) bgColor:UIButtonPinkColor(0.08) clearButtonImage:UIImageNamed(ICON_Button_Field_delete)];
    }
    return _inputField;
}

- (UILabel *)unitLabel {

    if (!_unitLabel) {
        _unitLabel = [UILabel new];
    }
    return _unitLabel;
}

- (UIButton *)chartButton {

    if (!_chartButton) {
        _chartButton = [UIButton new];
    }
    return _chartButton;
}

#pragma mark - ViewMethods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self setupUI];
    [self setupSourceData];
}

- (void)setupUI {

    WEAKSELF
    
    self.promptLabel.textAlignment = NSTextAlignmentCenter;
    self.promptLabel.numberOfLines = 0;
    [self.view addSubview:self.promptLabel];
    [self.promptLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(SCREEN_HEIGHT * 0.2);
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(@(SCREEN_WIDTH - 100));
    }];

    [self.inputField addTarget:self action:@selector(textFieldEditingChanged:) forControlEvents:UIControlEventEditingChanged];
    self.inputField.delegate = self;
    self.inputField.placeholder = @"基础体温";
    [self.view addSubview:self.inputField];
    [self.inputField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.promptLabel.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(@100);
        make.height.equalTo(@40);
    }];
    
    self.unitLabel.text = @"°C";
    self.unitLabel.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:self.unitLabel];
    [self.unitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.inputField.mas_right).offset(10);
        make.centerY.equalTo(weakSelf.inputField);
        make.width.equalTo(@30);
        make.height.equalTo(@40);
    }];
    
    self.chartButton.layer.cornerRadius = 5;
    self.chartButton.clipsToBounds = YES;
    self.chartButton.titleLabel.font = [UIFont systemFontOfSize:20];
    [self.chartButton setTitle:@"Chart" forState:UIControlStateNormal];
    [self.chartButton setBackgroundImage:[UIImage imageWithColor:UIButtonPinkColor(0.6)] forState:UIControlStateHighlighted];
    [self.chartButton setBackgroundImage:[UIImage imageWithColor:UIButtonPinkColor(1.0)] forState:UIControlStateNormal];
    [self.chartButton addTarget:self action:@selector(goToChartController:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.chartButton];
    [self.chartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.inputField.mas_bottom).offset(50);
        make.centerX.equalTo(weakSelf.view);
        make.width.equalTo(weakSelf.view).offset(- 100);
        make.height.equalTo(@40);
    }];
}
    
- (void)setupSourceData {

    self.promptLabel.text = @"请在清晨9点前测量基础体温 🔆💕 么哒...";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [self.inputField resignFirstResponder];
}

#pragma mark - UITextFieldTextDidChangeNotification

- (void)textFieldEditingChanged:(UITextField *)textField {

    textField.text = textField.text.length > 5 ? [textField.text substringToIndex:5] : textField.text;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    int temp = textField.text.intValue;
    if (temp < 30 || temp > 42) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您输入的基础体温数值超过了正常范围, 请重新输入!" preferredStyle:UIAlertControllerStyleAlert];
//        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
//        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:nil];
    }else {
        
        TEMPChartController *chartVC = [TEMPChartController new];
        [self.navigationController pushViewController:chartVC animated:YES];
        
        self.inputField.text = nil;
        [self.inputField resignFirstResponder];
    }

    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (self.inputField.subjectColor) {
        
        self.inputField.layer.borderColor = self.inputField.subjectColor.CGColor;
        self.inputField.layer.borderWidth = 1.0;
        self.inputField.layer.cornerRadius = 5;
        self.inputField.layer.masksToBounds = YES;
        self.inputField.backgroundColor = self.inputField.bgColor;
    }
    
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    self.inputField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputField.backgroundColor = [UIColor clearColor];
}

#pragma mark - ClickEvent

- (void)goToChartController:(UIButton *)sender {

    NSLog(@"%s", __FUNCTION__);
    [self.navigationController pushViewController:[[TEMPChartController alloc] initWithIsNotNavBarHidden:YES] animated:YES];
    
    self.inputField.text = nil;
    [self.inputField resignFirstResponder];
}

@end
