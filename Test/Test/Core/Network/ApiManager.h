//
//  ApiManager.h
//  Test
//
//  Created by qiandong on 7/8/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//
/*
 网络业务层：封装API接口。清晰的请求参数（多的话封装requestParam类），输出清晰的结果。
 本层之上，可视情况封装业务逻辑（manager）层。
 返回结果一般为：commonResult（success、errcode、message），业务结果，网络错误（error）
 */
#import <Foundation/Foundation.h>
#import "CommonResult.h"

#import "SystemInfo.h"
#import "Fund.h"
#import "User.h"
#import "Order.h"

@interface ApiManager : NSObject

+ (instancetype)shared;

- (void) querySystemInfoWithblock:(void (^)(CommonResult *commonResult, SystemInfo *systemInfo, NSError *error))block;

- (void) loginWithMobile:(NSString *)mobile
                password:(NSString *)password
                   block:(void (^)(CommonResult *commonResult, User *user, NSError *error))block;

- (void) authcodeWithMobile:(NSString *)mobile
                authcode:(NSString *)authcode
                   block:(void (^)(CommonResult *commonResult, NSError *error))block;

- (void) registerWithMobile:(NSString *)mobile
                   username:(NSString *)username
                     gender:(NSString *)gender
                   password:(NSString *)password
                   authcode:(NSString *)authcode
                      block:(void (^)(CommonResult *commonResult, NSError *error))block;

- (void) queryFundListWithCityId:(NSString *)city_id
                      categoryId:(NSString *)category_id
                            page:(NSString *)page
                           limit:(NSString *)limit
                          detail:(NSString *)detail
                           block:(void (^)(CommonResult *commonResult, NSArray *funds, NSError *error))block;

- (void) uploadAvatarWithImage:(NSData *)avatar
                             token:(NSString *)user_token
                             block:(void (^)(CommonResult *commonResult, User *user, NSError *error))block;

- (void) queryOrderListWithToken:(NSString *)user_token
                         block:(void (^)(CommonResult *commonResult, NSArray *orders, NSError *error))block;

@end
