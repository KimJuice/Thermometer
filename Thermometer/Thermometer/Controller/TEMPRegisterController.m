//
//  TEMPRegisterController.m
//  Thermometer
//
//  Created by milk on 2017/4/6.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPRegisterController.h"
#import "TEMPTextField.h"
#import "TEMPTabBarController.h"
#import "TEMPPermitManager.h"
#import "TEMPEditImageController.h"
#import "TEMPCameraController.h"
#import "TEMPKeyboardManager.h"

#define kBoxHeight 25
#define kBoxWidth SCREEN_WIDTH * 0.8

@interface TEMPRegisterController ()
<
UITextFieldDelegate,
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
TEMPCameraControllerDelegate,
TEMPKeyboardManagerDelegate
>

@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) UILabel *userNameLabel;
@property (nonatomic, strong) TEMPTextField *userNameField;
@property (nonatomic, strong) UILabel *emailLabel;
@property (nonatomic, strong) TEMPTextField *emailField;
@property (nonatomic, strong) UILabel *passWordLabel;
@property (nonatomic, strong) TEMPTextField *passWordField; // 101
@property (nonatomic, strong) UILabel *phoneLabel;
@property (nonatomic, strong) TEMPTextField *phoneField;
@property (nonatomic, strong) UIButton *signUpBtn;
@property (nonatomic, strong) UIImagePickerController *picker;
@property (nonatomic, strong) TEMPCameraController *cameraController;
@property (nonatomic, strong) UIImage *icon;

@property (nonatomic, strong) TEMPKeyboardManager *keyboardManager;
@property (nonatomic, strong) TEMPTextField *currentField;

@end

@implementation TEMPRegisterController

#pragma mark - LazyLoading

#pragma mark - ViewMethods

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    
    SETBACKGROUNDCOLOR(UIBgBlackColor)
    self.bgImageView.image = UIImageNamed(ICON_BG_Login);
    self.icon = UIImageNamed(ICON_Default_Portrait);
    self.keyboardManager = [[TEMPKeyboardManager alloc] initWithNotification:self];
    self.keyboardManager.keyboardDelegate = self;
    
    WEAKSELF
    
    self.iconBtn = [UIButton new];
    [self.iconBtn setBackgroundImage:UIImageNamed(ICON_Button_Add_Portrait) forState:UIControlStateNormal];
    [self.iconBtn addTarget:self action:@selector(setupPortrait:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.iconBtn];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view).offset(SCREEN_HEIGHT * 0.14);
        make.centerX.equalTo(weakSelf.view);
        make.size.mas_equalTo(CGICONSIZE);
    }];
    
    self.userNameLabel = [UILabel new];
    self.userNameLabel.textColor = UIFontWhiteColor(0.5);
    self.userNameLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    self.userNameLabel.text = @"USERNAME";
    [self.view addSubview:self.userNameLabel];
    [self.userNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.iconBtn.mas_bottom).offset(SCREEN_HEIGHT * 0.14 - 20);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(22);
    }];
    
    self.userNameField = [[TEMPTextField alloc] initWithLineType:CGSizeMake(kBoxWidth, kBoxHeight) subjectColor:UIFontWhiteColor(0.9) clearButtonImage:UIImageNamed(ICON_Button_Field_delete1) placeholder:@"Username" isSecureEntry:NO];
    self.userNameField.delegate = self;
    [self.view addSubview:self.userNameField];
    [self.userNameField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNameLabel.mas_bottom).offset(6);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(kBoxHeight);
    }];
    
    self.phoneLabel = [UILabel new];
    self.phoneLabel.textColor = UIFontWhiteColor(0.5);
    self.phoneLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    self.phoneLabel.text = @"PHONE";
    [self.view addSubview:self.phoneLabel];
    [self.phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.userNameField.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(22);
    }];
    
    self.phoneField = [[TEMPTextField alloc] initWithLineType:CGSizeMake(kBoxWidth, kBoxHeight) subjectColor:UIFontWhiteColor(0.9) clearButtonImage:UIImageNamed(ICON_Button_Field_delete1) placeholder:@"Telephone Number" isSecureEntry:NO];
    self.phoneField.keyboardType = UIKeyboardTypeNumberPad;
    self.phoneField.delegate = self;
    [self.view addSubview:self.phoneField];
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneLabel.mas_bottom).offset(6);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(kBoxHeight);
    }];
    
    self.emailLabel = [UILabel new];
    self.emailLabel.textColor = UIFontWhiteColor(0.5);
    self.emailLabel.font = [UIFont systemFontOfSize:14 weight:UIFontWeightThin];
    self.emailLabel.text = @"EMAIL";
    [self.view addSubview:self.emailLabel];
    [self.emailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.phoneField.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(22);
    }];
    
    self.emailField = [[TEMPTextField alloc] initWithLineType:CGSizeMake(kBoxWidth, kBoxHeight) subjectColor:UIFontWhiteColor(0.9) clearButtonImage:UIImageNamed(ICON_Button_Field_delete1) placeholder:@"Email Address" isSecureEntry:NO];
    self.emailField.keyboardType = UIKeyboardTypeEmailAddress;
    self.emailField.delegate = self;
    [self.view addSubview:self.emailField];
    [self.emailField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.emailLabel.mas_bottom).offset(6);
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
        make.top.equalTo(weakSelf.emailField.mas_bottom).offset(20);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(22);
    }];
    
    self.passWordField = [[TEMPTextField alloc] initWithLineType:CGSizeMake(kBoxWidth, kBoxHeight) subjectColor:UIFontWhiteColor(0.9) clearButtonImage:nil placeholder:@"••••••" isSecureEntry:YES];
    self.passWordField.delegate = self;
    self.passWordField.tag = 101;
    [self.view addSubview:self.passWordField];
    [self.passWordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passWordLabel.mas_bottom).offset(6);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(kBoxHeight);
    }];
    
    self.signUpBtn = [UIButton new];
    self.signUpBtn.backgroundColor = [UIColor whiteColor];
    [self.signUpBtn setTitle:@"Sign up" forState:UIControlStateNormal];
    [self.signUpBtn setTitleColor:UIFontBlackColor forState:UIControlStateNormal];
    [self.signUpBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0 alpha:0.2]] forState:UIControlStateHighlighted];
    [self.signUpBtn addTarget:self action:@selector(signUp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.signUpBtn];
    [self.signUpBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.passWordField.mas_bottom).offset(30);
        make.centerX.equalTo(weakSelf.view);
        make.width.mas_equalTo(kBoxWidth);
        make.height.mas_equalTo(40);
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self resignFirstResponders];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ClickEvent

- (void)setupPortrait:(UIButton *)sender {
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cameraAction = [UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            [UIAlertController alertControllerWithMessage:AVCameraNoSupport controller:self];
            return;
        }
        [TEMPPermitManager permitWithCamera:self];
        
        TEMPCameraController *camera = [TEMPCameraController new];
        camera.cameraDelegate = self;
        [self presentViewController:camera animated:YES completion:nil];
        
    } titleColor:UIFontBlackColor];
    
    UIAlertAction *libraryAction = [UIAlertAction actionWithTitle:@"Photo Library" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            
            [UIAlertController alertControllerWithMessage:AVPhotoLibraryNoSupport controller:self];
            return;
        }
        [TEMPPermitManager permitWithPhotoLibrary:self];
        
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

- (void)signUp:(UIButton *)sender {
    
    NSLog(@"%s",__FUNCTION__);
    [self savePortrait:self.icon userName:self.userNameField.text];
    [self.navigationController pushViewController:[TEMPTabBarController new] animated:YES];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    self.currentField = (TEMPTextField *)textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField.tag == 101) {
        
        [self signUp:self.signUpBtn];
    }
    
    [self resignFirstResponders];
    return YES;
}

#pragma mark - TEMPKeyboardManagerDelegate

- (void)keyboardChangeWithNotification:(NSNotification *)notification {
    
    [TEMPKeyboardManager setupKeyboardHeightwithView:self.view rect:self.currentField.frame notification:notification];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    image = [[TEMPCameraManager shareInstance] compressPicture:image];
    self.icon = image;
    [self.iconBtn setupWithPortrait:image iconSize:CGICONSIZE];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - TEMPCameraControllerDelegate

- (void)findPhotographWithImage:(UIImage *)image {
    
    self.icon = image;
    [self.iconBtn setupWithPortrait:image iconSize:CGICONSIZE];
}

#pragma mark - FunctionalMethod

- (void)savePortrait:(UIImage *)image userName:(NSString *)userName {
    
    NSString *path = [NSDocumentPath stringByAppendingPathComponent:@"Portrait"];
    if (![[NSFileManager defaultManager] isExecutableFileAtPath:path])
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    
    NSData *data = UIImagePNGRepresentation(image);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        if ([data writeToFile:[NSString stringWithFormat:@"%@/Portrait.PNG", path] atomically:YES]) {
            
            NSLog(@"The Portrait was written successfully!!!");
        }else {
            
            NSLog(@"The Portrait was written failed!!! Reason: %@", data.bytes);
        }
    });
}

- (void)resignFirstResponders {
    
    [self.userNameField resignFirstResponder];
    [self.phoneField resignFirstResponder];
    [self.emailField resignFirstResponder];
    [self.passWordField resignFirstResponder];
}

@end
