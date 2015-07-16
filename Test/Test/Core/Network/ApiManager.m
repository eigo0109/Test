//
//  ApiManager.m
//  Test
//
//  Created by qiandong on 7/8/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "ApiManager.h"
#import "HttpSessionManager.h"
#import "Apiurl.h"
#import "AFHTTPRequestOperationManager.h"




@implementation ApiManager

+ (instancetype)shared {
    static ApiManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[ApiManager alloc] init];
    });
    
    return _sharedManager;
}



#pragma mark - 初始化系统信息
- (void) querySystemInfoWithblock:(void (^)(CommonResult *commonResult, SystemInfo *systemInfo, NSError *error))block
{
    [[HttpSessionManager shared] GET:API_SYSTEM parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        CommonResult *commonResult = [CommonResult objectWithKeyValues:responseObject];

        SystemInfo *systemInfo = [SystemInfo objectWithKeyValues:responseObject[@"data"]];
        
        if (block) {
            block(commonResult,systemInfo, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];

}

#pragma mark - 业务相关
- (void)queryFundListWithCityId:(NSString *)city_id
                    categoryId:(NSString *)category_id
                          page:(NSString *)page
                         limit:(NSString *)limit
                        detail:(NSString *)detail
                         block:(void (^)(CommonResult *commonResult, NSArray *funds, NSError *error))block
{
    NSDictionary *params = @{@"city_id":NON_EMPTY_FOR_STRING(city_id),
                             @"category_id":NON_EMPTY_FOR_STRING(category_id),
                             @"page":NON_EMPTY_FOR_STRING(page),
                             @"limit":NON_EMPTY_FOR_STRING(limit),
                             @"detail":NON_EMPTY_FOR_STRING(detail)};
    
    [[HttpSessionManager shared] GET:API_DREAM parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        CommonResult *commonResult = [CommonResult objectWithKeyValues:responseObject];

        NSArray *funds = [Fund objectArrayWithKeyValuesArray:responseObject[@"data"]];

        if (block) {
            block(commonResult,funds, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil,[NSArray array], error);
        }
    }];
}

#pragma mark - 登陆注册相关
- (void) loginWithMobile:(NSString *)mobile
                password:(NSString *)password
                   block:(void (^)(CommonResult *commonResult, User *user, NSError *error))block
{
    NSDictionary *params = @{@"mobile":NON_EMPTY_FOR_STRING(mobile),
                             @"password":NON_EMPTY_FOR_STRING(password),
                             @"ios_client_id":NON_EMPTY_FOR_STRING([ESHelper deviceUUID])};
    
    [[HttpSessionManager shared] POST:API_LOGIN parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        CommonResult *commonResult = [CommonResult objectWithKeyValues:responseObject];
        
        User *user = [User objectWithKeyValues:responseObject[@"data"]];
        
        if (block) {
            block(commonResult, user, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil, nil, error);
        }
    }];
}

- (void) authcodeWithMobile:(NSString *)mobile
                   authcode:(NSString *)authcode
                      block:(void (^)(CommonResult *commonResult, NSError *error))block
{
    NSDictionary *params = @{@"mobile":NON_EMPTY_FOR_STRING(mobile),
                             @"authcode":NON_EMPTY_FOR_STRING(authcode)};
    
    [[HttpSessionManager shared] POST:API_AUTHCODE parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        CommonResult *commonResult = [CommonResult objectWithKeyValues:responseObject];
        
        if (block) {
            block(commonResult, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void) registerWithMobile:(NSString *)mobile
                   username:(NSString *)username
                     gender:(NSString *)gender
                   password:(NSString *)password
                   authcode:(NSString *)authcode
                      block:(void (^)(CommonResult *commonResult, NSError *error))block
{
    NSDictionary *params = @{@"mobile":NON_EMPTY_FOR_STRING(mobile),
                             @"username":NON_EMPTY_FOR_STRING(username),
                             @"gender":NON_EMPTY_FOR_STRING(gender),
                             @"password":NON_EMPTY_FOR_STRING(password),
                             @"authcode":NON_EMPTY_FOR_STRING(authcode)};
    
    [[HttpSessionManager shared] POST:API_REGISTER parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        CommonResult *commonResult = [CommonResult objectWithKeyValues:responseObject];
        
        if (block) {
            block(commonResult, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil, error);
        }
    }];
}

- (void) uploadAvatarWithImage:(NSData *)avatar
                             token:(NSString *)user_token
                             block:(void (^)(CommonResult *commonResult, User *user, NSError *error))block
{

}

- (void) queryOrderListWithToken:(NSString *)user_token
                           block:(void (^)(CommonResult *commonResult, NSArray *orders, NSError *error))block
{
    NSDictionary *params = @{@"user_token":NON_EMPTY_FOR_STRING(user_token)};
    
    [[HttpSessionManager shared] GET:API_ORDER parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        CommonResult *commonResult = [CommonResult objectWithKeyValues:responseObject];
        
        NSArray *orders = [Order objectArrayWithKeyValuesArray:responseObject[@"data"]];

        if (block) {
            block(commonResult, orders, nil);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (block) {
            block(nil, [NSArray array], error);
        }
    }];

}


@end
