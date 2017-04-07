//
//  TEMPSqlData.h
//  Thermometer
//
//  Created by milk on 2017/3/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TEMPSqlData : NSObject

@property (nonatomic, strong) FMDatabaseQueue *queue;

+ (instancetype)sharedInstance;
- (void)creatQueue;

/** Select **/

/**
 查询账户信息

 @param userName 用户名/邮箱

 @return 密码
 */
- (NSString *)selectWithAccountInfo:(NSString *)userName;

@end
