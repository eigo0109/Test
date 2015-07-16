//
//  ApiTest.m
//  Test
//
//  Created by qiandong on 7/16/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "ApiTest.h"
#import "ApiManager.h"

@implementation ApiTest

+(void)login
{
    [[ApiManager shared] loginWithMobile:@"13588046226"
                                password:@"123456"
                                   block:^(CommonResult *commonResult, User *user, NSError *error) {
                                       if (!error) {
                                           if(commonResult.success){
                                               [ESSession shared].user = user;
                                               NSLog(@"User : %@",user);
                                           }else{
                                               NSLog(@"message : %@",commonResult.message);
                                           }
                                       }else{
                                           ;
                                       }
                                   }];
}


+(void)run
{
    //    [[ApiManager shared] queryFundListWithCityId:nil
    //                                 categoryId:nil
    //                                       page:nil
    //                                      limit:nil
    //                                     detail:nil
    //                                      block:^(CommonResult *commonResult, NSArray *funds, NSError *error) {
    //                                          if (!error) {
    //                                              if(commonResult.success){
    //                                                  Fund *fund = [funds objectAtIndex:0];
    //                                                  NSLog(@"%@",fund);
    //                                              }
    //                                          }else{
    //                                              ;
    //                                          }
    //                                      }];
    //
    //
    //
    //    [[ApiManager shared] authcodeWithMobile:@"13588046226"
    //                                authcode:@"123456"
    //                                   block:^(CommonResult *commonResult, NSError *error) {
    //                                       if (!error) {
    //                                           if(commonResult.success){
    //                                               NSLog(@"authcode success : %i",commonResult.success);
    //                                           }else{
    //                                               NSLog(@"message : %@",commonResult.message);
    //                                           }
    //                                       }else{
    //                                           ;
    //                                       }
    //                                   }];
    //
    //    [[ApiManager shared] registerWithMobile:@"18857163176"
    //                                   username:@"qd"
    //                                     gender:@"1"
    //                                   password:@"111111"
    //                                   authcode:nil
    //                                      block:^(CommonResult *commonResult, NSError *error) {
    //                                          if (!error) {
    //                                              if(commonResult.success){
    //                                                  NSLog(@"register success : %i",commonResult.success);
    //                                              }else{
    //                                                  NSLog(@"message : %@",commonResult.message);
    //                                              }
    //                                          }else{
    //                                              ;
    //                                          }
    //    }];
}

+(void)runAfterLogin
{
    [[ApiManager shared] queryOrderListWithToken:[ESSession shared].user.user_token block:^(CommonResult *commonResult, NSArray *orders, NSError *error) {
        if (!error) {
            if(commonResult.success){
                NSLog(@"orders : %@",orders);
            }else{
                NSLog(@"message : %@",commonResult.message);
            }
        }else{
            ;
        }
    }];
}

@end
