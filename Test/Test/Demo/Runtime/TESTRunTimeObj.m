//
//  RunTimeObj.m
//  Test
//
//  Created by qiandong on 7/15/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "TESTRunTimeObj.h"
#import "MasListVC.h"
#import "MasView1.h"
#import "MasView2.h"

@implementation TESTRunTimeObj

+(void)test
{
    // YI
    NSArray *array = @[
                       [[MasListVC alloc] initWithTitle:@"Basic" viewClass:MasView1.class],
                       [[MasListVC alloc] initWithTitle:@"Basic" viewClass:MasView2.class]
                       ];

    NSLog(@"%@",array);
}

@end
