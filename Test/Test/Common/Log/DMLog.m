//
//  DMLog.m
//  BTTest
//
//  Created by linyong on 14-6-28.
//  Copyright (c) 2014年 wangzhiguang. All rights reserved.
//

#import "DMLog.h"
#import "ESHelper.h"

#define DMLOG_FILE_NAME  @"DMLog.log"

#define DMLOG_FILE_SIZE (10*1024*1024)

static DMLog *gDMLogInstance;


@implementation DMLog
{
    NSMutableArray *_LogQueue;
    NSThread *_LogThread;
    NSCondition *_LogSignal;
    NSString *_LogFilePath;
    NSFileHandle *_fileHandle;
}


- (void) createAndOpenLogFile
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *docPath = [ESHelper documentsPath];
    BOOL needBack = NO;
    [fileManager changeCurrentDirectoryPath:docPath];
    
    if (!_LogFilePath)
    {
        _LogFilePath = [[NSString alloc] initWithFormat:@"%@/%@",docPath,DMLOG_FILE_NAME];
    }
    
    if (![fileManager fileExistsAtPath:_LogFilePath])
    {
        [fileManager createFileAtPath:_LogFilePath contents:nil attributes:nil];
    }
    
    NSDictionary *fileAttribute = [fileManager attributesOfItemAtPath:_LogFilePath error:nil];
    if ([fileAttribute fileSize] >= DMLOG_FILE_SIZE)
    {
        needBack = YES;
    }
    
    if ([ESHelper getFreeSpace] <= DMLOG_FILE_SIZE)
    {
        needBack = YES;
    }
    
    if (_fileHandle)
    {
        [_fileHandle closeFile];
        [_fileHandle release];
        _fileHandle = nil;
    }
    
    _fileHandle = [[NSFileHandle fileHandleForWritingAtPath:_LogFilePath] retain];
    if (needBack)
    {
        [_fileHandle seekToFileOffset:0];
    }
}


- (BOOL) isLogFileCreated
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:_LogFilePath])
    {
        return NO;
    }
    
    return YES;
}


- (void) writeLogToFile:(NSArray *) logs
{
    if (![self isLogFileCreated])
    {
        [self createAndOpenLogFile];
    }
    
    for (NSString *logStr in logs)
    {
        NSData *writeBuf = [logStr dataUsingEncoding:NSUTF8StringEncoding];
        
        //需添加控制日志文件大小的功能
//        if ([self getLogFileSize] >= LOG_FILE_MAX_SIZE)
//        {
//            [logFileHandle seekToFileOffset:0];
//        }
//        else
        {
            [_fileHandle seekToEndOfFile];
        }
        [_fileHandle writeData:writeBuf];
        
    }
}


- (void) threadProc
{
    do
    {
        @autoreleasepool
        {
            for (int i = 0; i < 20; i++)
            {
                [_LogSignal lock];
                while ([_LogQueue count] == 0)
                {
                    [_LogSignal wait];
                }
                
                NSArray *items = [NSArray arrayWithArray:_LogQueue];
                [_LogQueue removeAllObjects];
                [_LogSignal unlock];
                
                
                if ([items count] > 0)
                {
                    [self writeLogToFile:items];
                }
            }
        }
    }while (YES);
}


- (void) startLogThread
{
    _LogThread = [[NSThread alloc] initWithTarget:self selector:@selector(threadProc) object:nil];
    [_LogThread setName:@"DM LOG"];
    [_LogThread start];
}

- (void) createLogQueue
{
    _LogQueue = [[NSMutableArray alloc] init];
}

- (void) createCondition
{
    _LogSignal = [[NSCondition alloc] init];
}

- (void) addLogToQueue:(NSString *) logStr
{
    [_LogSignal lock];
    [_LogQueue addObject:logStr];
    [_LogSignal signal];
    [_LogSignal unlock];
}

- (void) stopLogThread
{
    if (!_LogThread)
    {
        return;
    }
    
    [_LogThread cancel];
    [NSThread exit];
}


- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [self createAndOpenLogFile];
        [self createLogQueue];
        [self createCondition];
        [self startLogThread];
    }
    return self;
}


- (void)dealloc
{
    if (_LogQueue)
    {
        [_LogQueue removeAllObjects];
    }
    DMRELEASE(_LogQueue)
    
    DMRELEASE(_LogFilePath)
    
    if (_LogThread)
    {
        [self performSelectorOnMainThread:@selector(stopLogThread) withObject:nil waitUntilDone:YES];
        DMRELEASE(_LogThread)
    }
    
    
    DMRELEASE(_LogSignal)
    
    if (_fileHandle)
    {
        [_fileHandle closeFile];
    }
    
    DMRELEASE(_fileHandle)
    
    [super dealloc];
}


+ (DMLog*) shareInstance
{
    if (!gDMLogInstance)
    {
        gDMLogInstance = [[DMLog alloc] init];
    }
    
    return gDMLogInstance;
}


+ (void) destoryInstance
{
    if (gDMLogInstance)
    {
        [gDMLogInstance release];
        gDMLogInstance = nil;
    }
}

+ (void) initDMLog
{
    [DMLog shareInstance];
}


+ (void) releaseDMLog
{
    [DMLog destoryInstance];
}

- (long long) getLogFileSize
{
    NSFileManager* manager = [NSFileManager defaultManager];
    return [[manager attributesOfItemAtPath:_LogFilePath error:nil] fileSize]>>20;
}


+ (NSString *)getFilename:(const char*) filePath
{
    NSString *srcStr = [NSString stringWithCString:filePath encoding:NSUTF8StringEncoding];
    NSArray *tempArr = [srcStr componentsSeparatedByString:@"/"];
    if ([tempArr count] <= 0)
    {
        return nil;
    }
    
    NSString *destStr = [tempArr objectAtIndex:[tempArr count]-1];

    return destStr;
}


+ (NSString *)getNowDateString
{
    NSDate *now=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSS"];
    
    NSString *dstStr=[dateformatter stringFromDate:now];
    
    [dateformatter release];
    
    return dstStr;
}


+ (void) DMWriteLogLevel:(dmLogLevel) logLevel  format:(NSString *) format, ...
{
    if (!gDMLogInstance)
    {
        NSLog(@"please init DM LOG first!!!");
    }
    
    if (DM_CURRENT_LEVEL > logLevel || !format)
    {
        return;
    }
    
    NSString *levelStr;
    if (DM_LOG_ERROR == logLevel)
    {
        levelStr = @"DM_ERROR";
    }else if(DM_LOG_INFO == logLevel)
    {
        levelStr = @"DM_INFO";
    }else
    {
        levelStr = @"DM_DEBUG";
    }
    
    va_list args;
    va_start(args, format);
    NSString *str = [[NSString alloc] initWithFormat:format arguments:args];
    va_end(args);
    
    NSThread *curThread = [NSThread currentThread];
    
    NSString *logStrWithoutTime = [[NSString alloc] initWithFormat:@"[%@] THREAD:[0x%lx],%@ \r\n",levelStr,(long)curThread,str];
    
    NSLog(@"%@",logStrWithoutTime);//打印时系统自动打印时间
    
    NSString *logStr = [[NSString alloc] initWithFormat:@"%@ %@",[self getNowDateString],logStrWithoutTime];
    
    [gDMLogInstance addLogToQueue:logStr];//写入文件时需加入时间信息
    
    [str release];
    [logStrWithoutTime release];
    [logStr release];
}

@end





