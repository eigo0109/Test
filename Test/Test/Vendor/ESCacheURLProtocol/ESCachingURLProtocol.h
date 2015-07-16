//
//  ESCachingURLProtocol.h
//  ezvizsports
//
//  Created by qiandong on 7/2/15.
//  Copyright (c) 2015 hikvision. All rights reserved.
//

//使用方法：
//引入SystemConfigration.framework，libsqlite3.dylib. 引入fmdb。
//Appdelegate.m里，didFinishLaunchingWithOptions方法里一行代码注册protocol：[NSURLProtocol registerClass:[ESCachingURLProtocol class]];
//
//定制：
//修改ESCachingURLProtocol.m里，修改各个环节的相应方法。一般需修改的方法为：getCachedKeyFromUrl、canInitWithRequest。

#import <Foundation/Foundation.h>

@interface ESCachingURLProtocol : NSURLProtocol


@end
