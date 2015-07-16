//
//  ESSession.h
//  Test
//
//  Created by qiandong on 15/7/8.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "SystemInfo.h"

@interface ESSession : NSObject

+ (instancetype)shared;

@property(nonatomic,strong) SystemInfo *systemInfo;  //系统信息
@property(nonatomic,strong) User *user; //当前用户

@end
