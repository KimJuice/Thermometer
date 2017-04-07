//
//  TEMPAccountInfoModel.h
//  Thermometer
//
//  Created by milk on 2017/4/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TEMPCoderObjectManager.h"

@interface TEMPAccountInfoModel : TEMPCoderObjectManager

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *phone;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *key;

@end
