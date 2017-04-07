//
//  TEMPCoderObjectManager.m
//  Thermometer
//
//  Created by milk on 2017/4/7.
//  Copyright © 2017年 milk. All rights reserved.
//

#import "TEMPCoderObjectManager.h"
#import <objc/runtime.h>

@implementation TEMPCoderObjectManager

- (void)encodeWithCoder:(NSCoder *)aCoder {

    unsigned int count;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i = 0; i < count; i++) {
        
        Ivar ivar = ivars[i];
        const char *ivarName = ivar_getName(ivar);
        NSString *name = [NSString stringWithUTF8String:ivarName];
        id value = [self valueForKey:name];
        [aCoder encodeObject:value forKey:name];
    }
    free(ivars);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {

    if (self = [super init]) {
        
        unsigned int count;
        Ivar *ivars = class_copyIvarList([self class], &count);
        for (int i = 0; i < count; i++) {
            
            Ivar ivar = ivars[i];
            const char *ivarName = ivar_getName(ivar);
            NSString *name = [NSString stringWithUTF8String:ivarName];
            id value = [self valueForKey:name];
            [self setValue:value forKey:name];
        }
        free(ivars);
    }
    
    return self;
}

@end
