//
//  ESSession.m
//  Test
//
//  Created by qiandong on 15/7/8.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import "ESSession.h"

@implementation ESSession

+ (instancetype)shared {
    static ESSession *_sharedSession = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSession = [[ESSession alloc] init];
    });
    
    return _sharedSession;
}

@end
