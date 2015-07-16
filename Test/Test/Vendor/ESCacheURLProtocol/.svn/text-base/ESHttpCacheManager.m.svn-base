//
//  ESHttpCacheManager.m
//  ezvizsports
//
//  Created by qiandong on 7/2/15.
//  Copyright (c) 2015 hikvision. All rights reserved.
//

#import "ESHttpCacheManager.h"

#import "FMDatabase.h"
#import "FMDatabaseQueue.h"
#import "FMDatabaseAdditions.h"

//custom param
#define maxSize (30*1024*1024) //最大文件数，超过此值，则删除一部分数据。S1客户端一般是2000条请求记录为15M。
#define keepRecentlyRecordNum 2000 //保留最近的请求记录数
#define dbFileName @"/EsHttpCache.sqlite"

//sql
#define createSQL @"CREATE TABLE HttpCache ('pid' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'key' TEXT UNIQUE, 'data' TEXT)"

#define createIndexSQL @"CREATE INDEX key_index on HttpCache(key);"

#define replaceSQL @"REPLACE INTO HttpCache (key,data) VALUES(?,?)"

#define getByKeySQL @"SELECT * FROM HttpCache WHERE key = ?"

#define deleteAllSQL @"DELETE FROM HttpCache"

#define deleteOldCacheSQL [NSString stringWithFormat:@"DELETE FROM HttpCache where pid < ((SELECT Max(pid) FROM HttpCache)-%i)",keepRecentlyRecordNum]



@implementation ESHttpCacheManager

+ (instancetype)sharedManager {
    static ESHttpCacheManager *_sharedManager = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (id)init {
    self = [super init];
    if (!self) {
        return nil;
    }
    self.dbPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:dbFileName];
    
    return self;
}

#pragma mark-- Database Access

- (BOOL)testDB
{
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open])
    {
        if(![db tableExists:@"HttpCache"])
        {
            BOOL res = [db executeUpdate:createSQL];
            if (res) {
                res = [db executeUpdate:createIndexSQL];
            }
            [db close];
            return res;
        }
        return YES;
    }
    else
    {
        return NO;
    }
}


- (BOOL) insert:(ESCachedData *)entity {
    if(![self testDB]){
        return NO;
    }
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        BOOL res = [db executeUpdate:replaceSQL, entity.key,[NSKeyedArchiver archivedDataWithRootObject:entity]];
        [db close];
        return res;
    }
    return NO;
}

- (ESCachedData *)getCacheByKey:(NSString *)key {
    if(![self testDB]){
        return nil;
    }
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    ESCachedData *entity = nil;
    if ([db open]) {
        FMResultSet * rs = [db executeQuery:getByKeySQL,key];
        while ([rs next]) {
            NSData * data = [rs dataForColumn:@"data"];
            entity = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            break;
        }
        [db close];
    }
    return entity;
}

- (BOOL) deleteAll{
    if(![self testDB]){
        return NO;
    }
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        BOOL res = [db executeUpdate:deleteAllSQL];
        [db close];
        return res;
    }
    return NO;
}

- (BOOL) deleteOlderCache{
    if(![self testDB]){
        return NO;
    }
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        BOOL res = [db executeUpdate:deleteOldCacheSQL];
        [db close];
        return res;
    }
    return NO;
}

-(void)limitInsert:(ESCachedData *)entity
{
    if(arc4random_uniform(150) == 75){ //减少IO，150次save检查1次db size。所以实际db最大size会超过1M左右（150条记录）。
        if(![self testDB]){
            return;
        }
        NSError *error = nil;
        NSDictionary *fileDictionary = [[NSFileManager defaultManager] attributesOfItemAtPath:self.dbPath error:&error];
        if (error) {
            return;
        }
        unsigned long long fileSize = [fileDictionary fileSize];
        if (fileSize > maxSize) {
            [self deleteOlderCache];
        }
    }
    
    [self insert:entity];
}

@end
