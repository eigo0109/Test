//
//  DMLog.h
//  BTTest
//
//  Created by linyong on 14-6-28.
//  Copyright (c) 2014年 wangzhiguang. All rights reserved.
//

#import <Foundation/Foundation.h>

//控制日志等级

#ifdef ES_APP_DISTRIBUTION

#define MD_INFO
//#define MD_ERROR

#else

#define MD_DEBUG
//#define MD_INFO

#endif


#define LOG_FILE_MAX_SIZE  (4)//日志文件大小控制(单位:M)(未实现)

typedef enum dmLogLevel_
{
    DM_LOG_DEBUG = 0,
    DM_LOG_INFO,
    DM_LOG_ERROR,
    DM_LOG_MAX
}dmLogLevel;

#ifdef MD_DEBUG

#define DM_CURRENT_LEVEL DM_LOG_DEBUG

#elif defined MD_INFO

#define DM_CURRENT_LEVEL DM_LOG_INFO

#else

#define DM_CURRENT_LEVEL DM_LOG_ERROR

#endif





@interface DMLog : NSObject

+ (void) initDMLog;

+ (void) releaseDMLog;

+ (NSString *)getFilename:(const char*) filePath;

+ (void) DMWriteLogLevel:(dmLogLevel) logLevel  format:(NSString *) format, ...;

@end

#define DMLOG_DEBUG(fmt,...)  do{[DMLog  DMWriteLogLevel:DM_LOG_DEBUG format:(@"FILE:%@,FUNC:%s,LINE:%d ==> "fmt), \
[DMLog getFilename:__FILE__],__FUNCTION__,__LINE__,##__VA_ARGS__];}while(0);

#define DMLOG_INFO(fmt,...)  do{[DMLog  DMWriteLogLevel:DM_LOG_INFO format:(@"FILE:%@,FUNC:%s,LINE:%d ==> "fmt), \
[DMLog getFilename:__FILE__],__FUNCTION__,__LINE__,##__VA_ARGS__];}while(0);

#define DMLOG_ERROR(fmt,...)  do{[DMLog  DMWriteLogLevel:DM_LOG_ERROR format:(@"FILE:%@,FUNC:%s,LINE:%d ==> "fmt), \
[DMLog getFilename:__FILE__],__FUNCTION__,__LINE__,##__VA_ARGS__];}while(0);

#define DMLOG_ERROR_ASSERT(condition,desc) \
do{ \
    if (!(condition))\
        [DMLog  DMWriteLogLevel:DM_LOG_ERROR format:(@"FILE:%@,FUNC:%s,LINE:%d ==> %@"), \
            [DMLog getFilename:__FILE__],__FUNCTION__,__LINE__,(desc)]; \
}while(0);




