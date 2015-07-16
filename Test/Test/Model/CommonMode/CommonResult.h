//
//  CommonResult.h
//  Test
//
//  Created by qiandong on 7/8/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "BaseModel.h"
@interface CommonResult : BaseModel

@property(nonatomic,assign) BOOL success;
@property(nonatomic,copy) NSString *errcode;
@property(nonatomic,copy) NSString *message;

@end
