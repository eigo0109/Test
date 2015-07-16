//
//  User.h
//  Test
//
//  Created by qiandong on 7/8/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//


//user_token	String	用于身份认证，所有需要校验相关的API均需要提供此参数 32位
//uid	Int	用户ID
//mobile	String	手机号码
//username	String	昵称
//gender	Int	性别 0女 1男
//avatar	String	头像 资源URL+此值
#import "BaseModel.h"
@interface User : BaseModel

@property(nonatomic,copy) NSString *user_token;
@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *gender;
@property(nonatomic,copy) NSString *avatar;

@end
