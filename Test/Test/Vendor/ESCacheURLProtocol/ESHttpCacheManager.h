//
//  ESHttpCacheManager.h
//  ezvizsports
//
//  Created by qiandong on 7/2/15.
//  Copyright (c) 2015 hikvision. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESCachedData.h"

@interface ESHttpCacheManager : NSObject

@property(nonatomic,strong) NSString *dbPath;

+ (instancetype)sharedManager;

- (BOOL) insert:(ESCachedData *)entity ;
- (ESCachedData *)getCacheByKey:(NSString *)key;
- (BOOL) deleteOlderCache;
- (BOOL) deleteAll;
-(void)limitInsert:(ESCachedData *)entity;
//- (BOOL) deleteAll;


@end
