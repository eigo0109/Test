//
//  HttpManager.h
//  Test
//
//  Created by qiandong on 7/8/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@interface HttpSessionManager : AFHTTPSessionManager

+ (instancetype)shared;

@end
