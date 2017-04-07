//
//  TEMPLoginConfigurationManager.m
//  Thermometer
//
//  Created by milk on 2017/4/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPLoginConfigurationManager.h"

#define kAutoLoginModel @"AutoLoginConfiguration"
#define kLastLoginModel @"LastLoginConfiguration"

@implementation TEMPLoginConfigurationManager

+ (void)writtenAutoLoginConfiguration:(TEMPAccountInfoModel *)accountInfoModel {

    // Object -> NSData
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:accountInfoModel];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kAutoLoginModel];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)writtenLastLoginConfiguration:(TEMPAccountInfoModel *)accountInfoModel {

    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:accountInfoModel];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:kLastLoginModel];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(TEMPAccountInfoModel *)readAutoLoginConfiguration {

    // NSData -> Object
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kAutoLoginModel];
    TEMPAccountInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}

+(TEMPAccountInfoModel *)readLastLoginConfiguration {

    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kLastLoginModel];
    TEMPAccountInfoModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    return model;
}

@end
