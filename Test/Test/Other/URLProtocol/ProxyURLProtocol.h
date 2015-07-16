//
//  ProxyURLProtocol.h
//  PandoraBoy
//
//  Created by Rob Napier on 11/30/07.
//  Copyright 2007 __MyCompanyName__. All rights reserved.
//
// Special NSURLProtocol to capture information out of the stream.
// It does very little; most work is done by subclasses

#import <Foundation/Foundation.h>


@interface ProxyURLProtocol : NSURLProtocol {
    NSURLRequest *_request;
    NSURLConnection *_connection;
    NSMutableData *_data;
}

+ (void)registerProxyProtocols;

- (NSMutableData *)data;
- (NSString*)valueForParameter:(NSString*)parameter;

@end
