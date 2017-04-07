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

- (void)creatQueue {

    NSString *databasePath = [NSDocumentPath stringByAppendingPathComponent:@"DatabaseFile"];
    NSString *queuePath = [databasePath stringByAppendingPathComponent:@"AccountInfo.db"];
    
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
//        NSMutableString *tableList = [NSMutableString string];
//        [tableList appendString:@"CREATE TABLE 'CHART_TEMP' ( 'id' INTEGER PRIMARY KEY, 'IMDN_ID' TEXT NOT NULL, 'TEMP' REAL, 'TIME' TEXT, 'STATE' INTEGER);"];

        NSString *sql = @"CREATE TABLE 'ACCOUNT_INFO' ( 'id' INTEGER PRIMARY KEY, 'USERNAME' TEXT NOT NULL, 'EMAIL' TEXT, 'KEY' TEXT NOT NULL)";
        [queue inDatabase:^(FMDatabase *db) {

            BOOL isOK = [db executeUpdate:sql];
            NSLog(@"%@", isOK ? [NSString stringWithFormat:@"The database was created successfully!!! \nPATH: %@", queuePath] : [NSString stringWithFormat:@"The database was created failed!!! \nERROR: %@", db.lastErrorMessage]);
        }];
    }
    
    self.queue = [FMDatabaseQueue databaseQueueWithPath:queuePath];
}

- (NSString *)selectWithAccountInfo:(NSString *)userName {

    __block NSString *key = @"";
//    [self.queue ]
    
    return key;
}

@end
