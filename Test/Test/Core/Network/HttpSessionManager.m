//
//  HttpManager.m
//  Test
//
//  Created by qiandong on 7/8/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "HttpSessionManager.h"

@implementation HttpSessionManager

+ (instancetype)shared {
    static HttpSessionManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[HttpSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASE_URL]];
        _sharedManager.securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
    });
    
    return _sharedManager;
}

@end