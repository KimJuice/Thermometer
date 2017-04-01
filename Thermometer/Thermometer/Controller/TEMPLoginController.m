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
#import <objc/runtime.h>
#import "TEMPPermitManager.h"
#import "TEMPEditImageController.h"
#import "TEMPCameraController.h"

#define kBoxHeight 25
#define kBoxWidth SCREEN_WIDTH * 0.8

@interface TEMPLoginController ()
<
UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TEMPCameraControllerDelegate
>

@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) TEMPTextField *userNameField;
@property (nonatomic, strong) UILabel *passWordLabel;
@property (nonatomic, strong) TEMPTextField *passWordField;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIButton *forgotKeyBtn;
@property (nonatomic, strong) UIButton *signUpBtn;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) TEMPCameraController *cameraController;

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
    
    self.iconBtn = [UIButton new];
    [self setupIconBtn:self.iconBtn icon:nil];
    [self.iconBtn addTarget:self action:@selector(clickPortrait:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.iconBtn];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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
        make.top.equalTo(weakSelf.iconBtn.mas_bottom).offset(SCREEN_HEIGHT * 0.16 - 20);
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

- (void)setupIconBtn:(UIButton *)btn icon:(UIImage *)icon {

    icon = icon ?: [UIImage imageWithContentsOfFile:NSPortraitPath];
    
    if (icon) {
        
        [btn setupWithPortrait:icon iconSize:CGICONSIZE];
    }else {
        
        [btn setBackgroundImage:UIImageNamed(ICON_Button_Add_Portrait) forState:UIControlStateNormal];
    }
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

- (void)clickPortrait:(UIButton *)sender {

    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
            [UIAlertController alertControllerWithMessage:AVCameraNoSupport controller:self];
            return;
        }
        [TEMPPermitManager permitWithCamera:self];
        
//        self.picker = [[UIImagePickerController alloc] init];
//        self.picker.view.backgroundColor = UIBgBlackColor;
//        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
//        self.picker.delegate = self;
//        [self.picker setShowsCameraControls:YES];
//        [self presentViewController:self.picker animated:YES completion:nil];
        
        TEMPCameraController *camera = [TEMPCameraController new];
        camera.cameraDelegate = self;
        [self presentViewController:camera animated:YES completion:nil];
        
    } titleColor:UIFontBlackColor];

    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            [UIAlertController alertControllerWithMessage:AVPhotoLibraryNoSupport controller:self];
            return;
        }
        [TEMPPermitManager permitWithCamera:self];
        
        self.picker = [[UIImagePickerController alloc] init];
        self.picker.view.backgroundColor = UIBgBlackColor;
        self.picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        self.picker.delegate = self;
        [self.picker setAllowsEditing:YES];
        [self presentViewController:self.picker animated:YES completion:nil];
    
    } titleColor:UIFontBlackColor];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {} titleColor:[[UIColor redColor] colorWithAlphaComponent:0.8]];
    
    [alertController addAction:cameraAction];
    [alertController addAction:libraryAction];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

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

#pragma mark - UITextFieldDelegate

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {

    UIImage *image = info[UIImagePickerControllerOriginalImage];
    image = [[TEMPCameraManager shareInstance] compressPicture:image];
    [self setupIconBtn:self.iconBtn icon:image];
    [self savePortrait:image];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TEMPCameraControllerDelegate

- (void)findPhotographWithImage:(UIImage *)image {

    [self setupIconBtn:self.iconBtn icon:image];
    [self savePortrait:image];
}

#pragma mark - FunctionalMethod

- (void)savePortrait:(UIImage *)image {

    NSString *path = [NSDocumentPath stringByAppendingPathComponent:@"Portrait"];
    
    if (![[NSFileManager defaultManager] isExecutableFileAtPath:path])
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([data writeToFile:NSPortraitPath atomically:YES]) {
            
            NSLog(@"The Portrait was written successfully!!!");
        }else {
            
            NSLog(@"The Portrait was written failed!!! Reason: %@", data.bytes);
        }
    });
}

@end
