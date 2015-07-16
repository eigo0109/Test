//
//  Address.h
//  Test
//
//  Created by qiandong on 7/9/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

//"id": "1",
//"uid": "1",
//"realname": "张三",
//"mobile": "13444444444",
//"prov": "330000",
//"city": "330100",
//"address": "滨江区康恩贝大厦",
//"default": "0",
//"dateline": "1436096687"
#import "BaseModel.h"
@interface Address : BaseModel

@property(nonatomic,copy) NSString *uid;
@property(nonatomic,copy) NSString *realname;
@property(nonatomic,copy) NSString *mobile;
@property(nonatomic,copy) NSString *prov;
@property(nonatomic,copy) NSString *city;
@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *isDefault;
@property(nonatomic,copy) NSDate *dateline;

@end
