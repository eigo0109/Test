//
//  ESHelper.h
//  TestVODAPI
//
//  Created by kanhaiping on 15-3-23.
//  Copyright (c) 2015年 hikvision. All rights reserved.
//

#import <UIKit/UIKit.h>

//#define ES_APP_DISTRIBUTION   //控制发布版本

#define NON_EMPTY_FOR_STRING(string) ((string).length > 0 ?  (string) : @"")

#define DMRELEASE(object)  do{if(object){[object release];object = nil;}}while(0);

@interface ESHelper : NSObject

+ (NSString *)md5Encryption:(NSString *)orgString;
+ (NSString *) fileMD5:(NSString *) filePath;
+ (NSString *)usersIPhoneName;
+ (NSString *)deviceUUID;
+ (BOOL)checkDevice:(NSString *)name; //只能check 真实机器，模拟器会返回x64之类的
+ (void)clearCookie;
+ (long long) getFreeSpace;
//获取documents目录
+ (NSString *) documentsPath;

+ (NSString *)formatDate:(NSDate *) sourceDate;

+ (BOOL) isString:(NSString *) mainStr containString:(NSString *) subStr;

+ (BOOL)isString:(NSString *)str containStringAtLast:(NSString *)subStr;


+ (NSString *) tmpPath;

+ (NSString *) mediaPath;

+ (NSString *) cachePath;

+ (NSString *) currentWifiSSID;

+ (CGFloat) getWidthWithString:(NSString *) str font:(UIFont*) font;

+ (void) autoScreenLockEnable:(BOOL) isEnable;

+ (void) changeBackBarButtonTo:(UIViewController*) controller action:(SEL) selector;

+ (UIBarButtonItem *) leftBarButtonWithNormalImage:(UIImage *) normalImage
                                      hilightedImage:(UIImage *) hilightImage
                                              target:(id) target
                                              action:(SEL) selector;
+ (UIBarButtonItem *) rightBarButtonWithNormalImage:(UIImage *) normalImage
                                      hilightedImage:(UIImage *) hilightImage
                                              target:(id) target
                                              action:(SEL) selector;

+ (BOOL)isCurrentLanguageChinese;

+ (NSString *)appVersion;

+ (NSInteger) makeAgeByBirthday:(long long) birthday;
+ (NSString *) makeAgeStringWithBirthday:(long long) birthday;

+ (void) addTapGestureToView:(UIView *) view target:(id) target selector:(SEL) selector;

+ (BOOL) checkIsTelephoneNumber:(NSString *)str;

+ (NSString *)formatBadgeStr:(NSInteger)count;

+ (NSDictionary *) parserUrlQuery:(NSString *) query encoding:(NSStringEncoding) encoding;

//字符串转颜色
+ (UIColor *) colorWithHexString: (NSString *) stringToConvert;

+ (NSDate *)UTCDate:(NSDate *)date;

//访问，如intervalComponents.second
+ (NSDateComponents *)intervalWithLate:(NSDate *)lateDate Early:(NSDate *)earlyDate;

@end
