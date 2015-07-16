//
//  RNCacheData.m
//  ezvizsports
//
//  Created by qiandong on 7/2/15.
//  Copyright (c) 2015 hikvision. All rights reserved.
//

#import "ESCachedData.h"


static NSString *const kKeyTag = @"key";
static NSString *const kDataTag = @"data";
static NSString *const kResponseTag = @"response";
static NSString *const kRedirectRequestTag = @"redirectRequest";

@implementation ESCachedData

@synthesize key =key_;
@synthesize data = data_;
@synthesize response = response_;
@synthesize redirectRequest = redirectRequest_;

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:[self key] forKey:kKeyTag];
    [aCoder encodeObject:[self data] forKey:kDataTag];
    [aCoder encodeObject:[self response] forKey:kResponseTag];
    [aCoder encodeObject:[self redirectRequest] forKey:kRedirectRequestTag];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self != nil) {
        [self setKey:[aDecoder decodeObjectForKey:kKeyTag]];
        [self setData:[aDecoder decodeObjectForKey:kDataTag]];
        [self setResponse:[aDecoder decodeObjectForKey:kResponseTag]];
        [self setRedirectRequest:[aDecoder decodeObjectForKey:kRedirectRequestTag]];
    }
    
    return self;
}

@end