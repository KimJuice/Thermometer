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
- (FMDatabaseQueue *)creatQueue;

@end
