//
//  TEMPSqlData.m
//  Thermometer
//
//  Created by milk on 2017/3/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPSqlData.h"

@implementation TEMPSqlData

+ (instancetype)sharedInstance {
    
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (FMDatabaseQueue *)creatQueue {

    NSString *databasePath = [NSDocumentPath stringByAppendingPathComponent:@"DatabaseFile"];
    NSString *queuePath = [databasePath stringByAppendingPathComponent:@"Thermometer.db"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:queuePath]) {
        
        [[NSFileManager defaultManager] createDirectoryAtPath:databasePath withIntermediateDirectories:YES attributes:nil error:nil];
        
        FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:queuePath];

        /* STATE:
         * 安全期: 0
         * 月经期: 1
         * 排卵期: 2
         * 排卵日: 3
         * 过渡期: 4
         */
        NSString *tableList = @"CREATE TABLE 'CHART_TEMP' ( 'id' INTEGER PRIMARY KEY, 'IMDN_ID' TEXT NOT NULL, 'TEMP' REAL, 'TIME' TEXT, 'STATE' INTEGER);";
        [queue inDatabase:^(FMDatabase *db) {

            NSLog(@"%@", [db executeStatements:tableList] ? [NSString stringWithFormat:@"The database was created successfully!!! \nPATH: %@", queuePath] : [NSString stringWithFormat:@"The database was created failed!!! \nERROR: %@", db.lastErrorMessage]);
        }];
    }
    
    self.queue = [FMDatabaseQueue databaseQueueWithPath:queuePath];
    return self.queue;
}
@end
