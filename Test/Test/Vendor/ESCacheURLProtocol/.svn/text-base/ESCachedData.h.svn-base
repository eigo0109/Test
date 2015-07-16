//
//  RNCacheData.h
//  ezvizsports
//
//  Created by qiandong on 7/2/15.
//  Copyright (c) 2015 hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ESCachedData : NSObject <NSCoding>

@property (nonatomic, readwrite, strong) NSString *key; //32位，由requestURL sha1算法生成
@property (nonatomic, readwrite, strong) NSData *data;
@property (nonatomic, readwrite, strong) NSURLResponse *response;
@property (nonatomic, readwrite, strong) NSURLRequest *redirectRequest;

@end
