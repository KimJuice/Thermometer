//
//  TEMPLoginConfigurationManager.h
//  Thermometer
//
//  Created by milk on 2017/4/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEMPAccountInfoModel.h"

@interface TEMPLoginConfigurationManager : NSObject

/** Written **/
+ (void)writtenAutoLoginConfiguration:(TEMPAccountInfoModel *)accountInfoModel;
+ (void)writtenLastLoginConfiguration:(TEMPAccountInfoModel *)accountInfoModel;

/** Read **/
+ (TEMPAccountInfoModel *)readAutoLoginConfiguration;
+ (TEMPAccountInfoModel *)readLastLoginConfiguration;

@end
