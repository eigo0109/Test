//
//  ESHelper.m
//  TestVODAPI
//
//  Created by kanhaiping on 15-3-23.
//  Copyright (c) 2015年 hikvision. All rights reserved.
//

#import "ESHelper.h"
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>
#import "GTMBase64.h"
#import "SSKeychain.h"
//#import "VodAPIs.h"

#import <sys/param.h>
#import <sys/mount.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#import <sys/utsname.h>


#define ONE_DAY_INTERVAL (24*3600)
#define DM_CHUNK_SIZE (256)

#define MEDIA_PATH  @"Media"
#define MEDIA_CACHE_PATH @"cache"

@implementation ESHelper
/** @fn	md5Encryption
 *  @brief  MD5加密
 *  @param  orgString - 要加密的string
 *  @return 返回加密结果
 */
+ (NSString *)md5Encryption:(NSString *)orgString
{
    const char *cStr = [orgString UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

+ (NSString *) fileMD5:(NSString *) filePath
{
    NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:filePath];
    if (!handle)
    {
        return nil;
    }
    
    CC_MD5_CTX md5;
    CC_MD5_Init(&md5);
    
    while (YES)
    {
        NSData *fileData = [handle readDataOfLength:DM_CHUNK_SIZE];
        if ([fileData length] == 0)
        {
            break;
        }
        CC_MD5_Update(&md5, [fileData bytes], (unsigned int)[fileData length]);
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &md5);
    
    NSString *retMD5Str = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                           digest[0],digest[1],
                           digest[2],digest[3],
                           digest[4],digest[5],
                           digest[6],digest[7],
                           digest[8],digest[9],
                           digest[10],digest[11],
                           digest[12],digest[13],
                           digest[14],digest[15]];
    
    
    return retMD5Str;
}

+ (NSString *)usersIPhoneName
{
    NSString *name = [[NSString alloc] initWithData:[[UIDevice currentDevice].name dataUsingEncoding:NSUTF8StringEncoding] encoding:NSUTF8StringEncoding];
    NSString *emojiName = [self stringContainsEmoji:name];
    
    if ([emojiName length] == 0)
    {
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
            emojiName = @"iPad";
        }
        emojiName = @"iPhone";
    }
    
    NSData * data = [GTMBase64 encodeData:[emojiName dataUsingEncoding:NSUTF8StringEncoding]];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

+ (NSString *)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    __block NSString *returnString = @"";
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop)
     {
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff)
         {
             if (substring.length > 1)
             {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f)
                 {
                     returnValue = YES;
                 }
             }
         }
         else if (substring.length > 1)
         {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3)
             {
                 returnValue = YES;
             }
         }
         else
         {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff)
             {
                 returnValue = YES;
             }
             else if (0x2B05 <= hs && hs <= 0x2b07)
             {
                 returnValue = YES;
             }
             else if (0x2934 <= hs && hs <= 0x2935)
             {
                 returnValue = YES;
             }
             else if (0x3297 <= hs && hs <= 0x3299)
             {
                 returnValue = YES;
             }
             else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50)
             {
                 returnValue = YES;
             }
         }
         
         if (returnValue == YES)
         {
             returnValue = NO;
         }
         else
         {
             returnString = [[returnString stringByAppendingString:substring] copy];
         }
     }];
    
    return returnString;
}

/**
 * 获取UUID，设备通用标示符
 */
+ (NSString *)deviceUUID
{
    // 钥匙串中先检查是否有UUID
    NSString * strUUID = [SSKeychain passwordForService:[[NSBundle mainBundle] bundleIdentifier] account:@"uuid"];
    if ([strUUID length] > 0)
    {
        return [self md5Encryption:strUUID];
    }
    
    CFUUIDRef puuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef uuidString = CFUUIDCreateString(kCFAllocatorDefault, puuid);
    strUUID = [NSString stringWithFormat:@"%@", (__bridge NSString*)uuidString];
    CFRelease(puuid);
    CFRelease(uuidString);
    
    [SSKeychain setPassword:strUUID forService:[[NSBundle mainBundle] bundleIdentifier] account:@"uuid"];
    
    return [self md5Encryption:strUUID];
}

+ (BOOL)checkDevice:(NSString *)name
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString =[NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    NSLog(@"ZZZ:%@",deviceString);
    NSRange range = [deviceString rangeOfString:name];
    return range.location != NSNotFound;
}

+ (void) clearCookie
{
    [ESHelper clearCookieAll];
//    [DMUtil clearCookieWithDomain:[CHikUtility getHttpServerDomain]];
//    [DMUtil clearCookieWithDomain:[CHikUtility getHttpsServerDomain]];
//    [DMUtil clearCookieWithDomain:@".ys7.com"];
}

+ (void) clearCookieAll
{
    NSArray *httpArray = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    for (NSHTTPCookie *cookie in httpArray)
    {
        [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
    }
}

+ (NSString *) documentsPath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docPath = [paths objectAtIndex:0];
    return docPath;
}

+ (long long) getFreeSpace
{
    struct statfs buf;
    long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (long long)(buf.f_bsize*buf.f_bfree);
    }
    return freeSpace;
}


+ (NSString *) ignoreYearWithDate:(NSDate*) date
{
    if (!date)
    {
        return nil;
    }
    
    NSDateFormatter *dateFormmatter = [[NSDateFormatter alloc] init];
    [dateFormmatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormmatter stringFromDate:date];
    
    [dateFormmatter setDateFormat:@"yyyy"];
    NSString *curYearStr = [dateFormmatter stringFromDate:[NSDate date]];
    
    NSArray *tempArray = [dateStr componentsSeparatedByString:@"-"];
    if (!tempArray || tempArray.count != 3)
    {
        return nil;
    }
    
    NSString *year = [[tempArray objectAtIndex:0] isEqualToString:curYearStr]?nil:[tempArray objectAtIndex:0];
    NSString *month = [tempArray objectAtIndex:1];
    NSString *day = [tempArray objectAtIndex:2];
    if ([month hasPrefix:@"0"])
    {
        month = [month substringWithRange:NSMakeRange(1,1)];
    }
    
    if ([day hasPrefix:@"0"])
    {
        day = [day substringWithRange:NSMakeRange(1,1)];
    }
    
    NSString *destStr = nil;
    
    if (year)
    {
        destStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",year,NSLocalizedString(@"helper_year", @"helper_year"),month,NSLocalizedString(@"helper_month", @"helper_month"),day,NSLocalizedString(@"helper_day", @"helper_day")];
    }
    else
    {
        destStr = [NSString stringWithFormat:@"%@%@%@%@",month,NSLocalizedString(@"helper_month", @"helper_month"),day,NSLocalizedString(@"helper_day", @"helper_day")];
    }
    
    return destStr;
}

+ (NSString *)formatDate:(NSDate *) sourceDate
{
    NSDate *now = [NSDate date];
    long long interval = [now timeIntervalSinceDate:sourceDate];
    
    NSString *destStr = nil;
    if (interval < 60)
    {
        destStr = NSLocalizedString(@"helper_just_now", @"helper_just_now");
    }
    else if (interval < ONE_DAY_INTERVAL)
    {
        long long h = interval/(3600);
        long long m = (interval - (h*3600))/60;
        if (h <= 0)
        {
            destStr = [NSString stringWithFormat:@"%lld%@",m,NSLocalizedString(@"helper_mins_ago", @"helper_mins_ago")];
        }
        else
        {
            destStr = [NSString stringWithFormat:@"%lld%@",h,NSLocalizedString(@"helper_hours_ago", @"helper_hours_ago")];
        }
    }
    else
    {
        NSTimeZone *localTimeZone = [NSTimeZone systemTimeZone];
        long long nowInterval = [now timeIntervalSince1970];
        long long tempInterval = nowInterval%(ONE_DAY_INTERVAL) + [localTimeZone secondsFromGMT];
        long long todayInterval = nowInterval - tempInterval;
        long long yesterdayInterval = todayInterval - ONE_DAY_INTERVAL;
        long long sourceDateInterval = [sourceDate timeIntervalSince1970];
        if (sourceDateInterval >= yesterdayInterval && sourceDateInterval < todayInterval)
        {
            destStr = NSLocalizedString(@"helper_yesterday", @"helper_yesterday");
        }
        else
        {
            destStr = [ESHelper ignoreYearWithDate:sourceDate];
        }
    }
    
    return destStr;
}

+ (BOOL) isString:(NSString *) mainStr containString:(NSString *) subStr
{
    if (!mainStr || !subStr || mainStr.length == 0 || subStr.length == 0)
    {
        return NO;
    }
    
    if (DEVICE_SYSTEM_VERSION >= 8.0)
    {
        return [mainStr containsString:subStr];
    }
    else
    {
        NSRange strRange = [mainStr rangeOfString:subStr];
        return strRange.length > 0;
    }
}

+ (BOOL)isString:(NSString *)str containStringAtLast:(NSString *)subStr {
    return [str hasSuffix:subStr];
}


+ (NSString *) tmpPath
{
    return NSTemporaryDirectory();
}

+ (NSString *) mediaPath
{
    NSString *mediaPath = [NSString stringWithFormat:@"%@/%@",[ESHelper documentsPath],MEDIA_PATH];
    return mediaPath;
}

+ (NSString *) cachePath
{
    NSString *cachePath = [NSString stringWithFormat:@"%@/%@",[ESHelper documentsPath],MEDIA_CACHE_PATH];
    return cachePath;
}


+ (NSString *) currentWifiSSID
{
    NSString *ssid = nil;
    NSArray *ifs = (__bridge_transfer NSArray*)CNCopySupportedInterfaces();
    for (NSString *ifnam in ifs)
    {
        NSDictionary *info = (__bridge_transfer NSDictionary*)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        if ([info objectForKey:@"SSID"])
        {
            ssid = [NSString stringWithString:[info objectForKey:@"SSID"]];
//            [info release];
            break;
        }
//        [info release];
    }
//    [ifs release];
    
    DMLOG_DEBUG(@"current ssid :%@",ssid);
    
    return ssid;
}

+ (CGFloat) getWidthWithString:(NSString *) str font:(UIFont*) font
{
    if (!str || str.length == 0)
    {
        return 0;
    }
    
    CGSize size = [str sizeWithFont:font];
    
    return size.width;
}

+ (void) autoScreenLockEnable:(BOOL) isEnable
{
    [UIApplication sharedApplication].idleTimerDisabled = !isEnable;
}

+ (void) changeBackBarButtonTo:(UIViewController*) controller action:(SEL) selector
{
    if (!controller)
    {
        return;
    }
    
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 65, 20)];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:NSLocalizedString(@"login_btn_back", @"login_btn_back") forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:17.0f];
    [btn setTitleColor:[UIColor whiteColor ] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor colorWithRed:1.0f green:168.0/255 blue:65.0/255 alpha:1.0f] forState:UIControlStateHighlighted];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_normal"] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"back_pressed"] forState:UIControlStateHighlighted];
    
    if (selector)
    {
        [btn addTarget:controller action:selector forControlEvents:UIControlEventTouchUpInside];
    }
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
    controller.navigationItem.leftBarButtonItem = barButton;
}


+ (UIBarButtonItem *) createBarButtonWithNormalImage:(UIImage *) normalImage
                                      hilightedImage:(UIImage *) hilightImage
                                              isLeft:(BOOL)isLeft
                                              target:(id) target
                                              action:(SEL) selector
{
    UIButtonType btnType = UIButtonTypeCustom;
//    if (!hilightImage)
//    {
//        btnType = UIButtonTypeRoundedRect;
//    }
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.frame = CGRectMake(0, 0, 44, 44);
    CGFloat offset = iOS7 ? (13.0 * (isLeft ? 1 : -1)) : 0.0;
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, -offset, 0, +offset);
    if (normalImage)
    {
        [btn setImage:normalImage forState:UIControlStateNormal];
    }
    
    if (hilightImage)
    {
        [btn setImage:hilightImage forState:UIControlStateHighlighted];
    }

    [btn addTarget:target action:selector forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    
    return backItem;
}
+ (UIBarButtonItem *) leftBarButtonWithNormalImage:(UIImage *) normalImage
                                    hilightedImage:(UIImage *) hilightImage
                                            target:(id) target
                                            action:(SEL) selector {
    return  [self createBarButtonWithNormalImage:normalImage hilightedImage:hilightImage
                                          isLeft:YES target:target action:selector];
}

+ (UIBarButtonItem *) rightBarButtonWithNormalImage:(UIImage *) normalImage
                                     hilightedImage:(UIImage *) hilightImage
                                             target:(id) target
                                             action:(SEL) selector {
    return [self createBarButtonWithNormalImage:normalImage hilightedImage:hilightImage
                                         isLeft:NO target:target action:selector];
}

+ (BOOL)isCurrentLanguageChinese
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults]; 
    NSArray *languages = [defaults objectForKey:@"AppleLanguages"];
    NSString *currentLanguage = [languages objectAtIndex:0];
    return [currentLanguage isEqualToString:@"zh-Hans"];
}

+ (NSString *)appVersion
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *versionDate = [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString*)kCFBundleVersionKey];
    return [NSString stringWithFormat:@"%@.%@",version,versionDate];
}

+ (NSInteger) makeAgeByBirthday:(long long) birthday
{
    NSDate *tempBirthday = [NSDate dateWithTimeIntervalSince1970:(double)(birthday/1000)];
    NSDate *nowDate = [NSDate date];
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* birthdayComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:tempBirthday];
    NSDateComponents* nowComponents = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:nowDate];
    
    return nowComponents.year - birthdayComponents.year > 0?nowComponents.year - birthdayComponents.year:0;
}

+ (NSString *) makeAgeStringWithBirthday:(long long) birthday
{
    NSString *ageStr = nil;
    NSInteger ageCount = [ESHelper makeAgeByBirthday:birthday];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *tempDate = [formatter dateFromString:@"1900-01-01 00:00:00"];
    NSInteger tempAgeCount = [ESHelper makeAgeByBirthday:[tempDate timeIntervalSince1970]*1000];
    
    if (tempAgeCount < ageCount)
    {
        ageStr = NSLocalizedString(@"self_secret", @"self_secret");
    }
    else
    {
        ageStr = [NSString stringWithFormat:@"%ld",(long)ageCount];
    }
    
    return ageStr;
}

+ (void) addTapGestureToView:(UIView *) view target:(id) target selector:(SEL) selector
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
    [view addGestureRecognizer:tap];
}

+ (BOOL) checkIsTelephoneNumber:(NSString *)str
{
    if (!str || str.length == 0)
    {
        return NO;
    }
    
    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    return isMatch;
}

+ (NSString *)formatBadgeStr:(NSInteger)count
{
    NSString *badgeStr = nil;
    if (count > 99) {
        badgeStr = @"99+";
    }else if(count > 0){
        badgeStr = [NSString stringWithFormat:@"%ld",(long)count];
    }
    return badgeStr;
}

+ (NSDictionary *) parserUrlQuery:(NSString *) query encoding:(NSStringEncoding) encoding
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    NSArray *tempArray = [query componentsSeparatedByString:@"&"];
    if (!tempArray || tempArray.count == 0)
    {
        return nil;
    }
    
    for (NSString *tempStr in tempArray)
    {
        NSArray *array = [tempStr componentsSeparatedByString:@"="];
        if (array.count != 2)
        {
            continue;
        }
        
        NSString *keyStr = [array objectAtIndex:0];
        NSString *valueStr = [array objectAtIndex:1];
        
        keyStr = [keyStr stringByReplacingPercentEscapesUsingEncoding:encoding];
        valueStr = [valueStr stringByReplacingPercentEscapesUsingEncoding:encoding];
        
        [dic setValue:valueStr forKey:keyStr];
    }
    
    return dic;
}

//字符串转颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert
{
    NSString *cString = [[stringToConvert stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    
    if ([cString length] < 6)
        return [UIColor whiteColor];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor whiteColor];
    
    NSRange range;
    range.location = 0;
    range.length = 2;
    NSString *rString = [cString substringWithRange:range];
    
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f)
                           green:((float) g / 255.0f)
                            blue:((float) b / 255.0f)
                           alpha:1.0f];
}

+ (NSDate *)UTCDate:(NSDate *)date
{
    // grab the current calendar and date
    NSCalendar *cal = [NSCalendar currentCalendar];
    // create UTC date components
    NSDateComponents *utcComponents = [cal components: NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSYearCalendarUnit fromDate: date];
    utcComponents.timeZone = [NSTimeZone timeZoneWithName: @"UTC"];
    return [cal dateFromComponents: utcComponents];
}

+ (NSDateComponents *)intervalWithLate:(NSDate *)lateDate Early:(NSDate *)earlyDate
{
    NSTimeInterval theTimeInterval = [lateDate timeIntervalSinceDate:earlyDate];
    // Get the system calendar
    NSCalendar *sysCalendar = [NSCalendar currentCalendar];
    // Create the NSDates
    NSDate *targetDate = [[NSDate alloc] initWithTimeInterval:theTimeInterval sinceDate:[NSDate date]];
    // Get conversion to months, days, hours, minutes
    NSCalendarUnit unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents *intervalComponents = [sysCalendar components:unitFlags fromDate:[NSDate date]  toDate:targetDate  options:0];
    return intervalComponents;
}

@end
