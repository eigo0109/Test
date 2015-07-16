//
//  SystemInfo.m
//  Test
//
//  Created by qiandong on 7/9/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "SystemInfo.h"

@implementation SystemInfo

+ (NSDictionary *)objectClassInArray
{
    return @{
             @"cityList" : @"City",
             @"categoryList" : @"FundCategory"
             };
}

+ (NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"cityList" : @"city",
             @"categoryList" : @"category"
             };
}

@end
