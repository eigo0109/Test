//
//  BaseModel.m
//  mlh
//
//  Created by qd on 13-5-8.
//  Copyright (c) 2013年 sunday. All rights reserved.
//

#import "BaseModel.h"
#import <objc/runtime.h>

@implementation BaseModel

- (id)newValueFromOldValue:(id)oldValue property:(MJProperty *)property
{
    if (property.type.typeClass == [NSDate class]) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[oldValue integerValue]];
        return date;
    }
    return oldValue;
}

@end





//- (id)initWithAttributes:(NSDictionary *)attributes
//{
//    if (self = [super init]) {
//        Class class = [self class];
//        while (class) {
//            [self setPropertiesForClass:class withDic:attributes];
//            class = class_getSuperclass(class);
//        }
//    }
//    return self;
//}
//
//- (void)setPropertiesForClass:(Class)class withDic:(NSDictionary *)dic{
//    if (!dic || ![dic isKindOfClass:[NSDictionary class]] || dic.count <= 0)//异常处理
//    {
//        return;
//    }
//    unsigned int nCount = 0;
//    objc_property_t *popertylist = class_copyPropertyList(class,&nCount);
//    for (int i = 0; i < nCount; i++)
//    {
//        objc_property_t property = popertylist[i];
//        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
//        propertyName = [self misMatchProperty:propertyName]; //misMatch
//        id value = dic[propertyName];
//        if (!value || [value isKindOfClass:[NSNull class]])
//        {
//            continue;
//        }else {
//            NSString *propertyStr = [NSString stringWithCString:property_getAttributes(property) encoding:NSUTF8StringEncoding];
//            NSRange range = [propertyStr rangeOfString:@"T"];
//            if (range.length > 0) {
//                NSString *type = [propertyStr substringWithRange:NSMakeRange(range.location + range.length, 1)];
//                if ([type isEqualToString:@"@"]) {
//                    [self setValue:value forKey:propertyName];
//                }else {
//                    if ([value isKindOfClass:[NSNumber class]]){
//                        NSNumber *dicValue = value;
//                        SEL propertySetterSelector = [self setterSelectorForPropertyName:propertyName];
//                        IMP imp = [self methodForSelector:propertySetterSelector];
//                        if ([type isEqualToString:[NSString stringWithCString:@encode(long long)
//                                                                     encoding:NSUTF8StringEncoding]]) {
//                            void (*func)(id, SEL, long long) = (void *)imp;
//                            func(self, propertySetterSelector, [dicValue longLongValue]);
//                        }else if ([type isEqualToString:[NSString stringWithCString:@encode(long)
//                                                                           encoding:NSUTF8StringEncoding]]) {
//                            void (*func)(id, SEL, long) = (void *)imp;
//                            func(self, propertySetterSelector, [dicValue longValue]);
//                        }else if ([type isEqualToString:[NSString stringWithCString:@encode(int)
//                                                                           encoding:NSUTF8StringEncoding]]) {
//                            void (*func)(id, SEL, int) = (void *)imp;
//                            func(self, propertySetterSelector, [dicValue intValue]);
//                        }else if ([type isEqualToString:[NSString stringWithCString:@encode(float)
//                                                                           encoding:NSUTF8StringEncoding]]) {
//                            void (*func)(id, SEL, float) = (void *)imp;
//                            func(self, propertySetterSelector, [dicValue floatValue]);
//                        }else if ([type isEqualToString:[NSString stringWithCString:@encode(double)
//                                                                           encoding:NSUTF8StringEncoding]]) {
//                            void (*func)(id, SEL, double) = (void *)imp;
//                            func(self, propertySetterSelector, [dicValue doubleValue]);
//                        }else if ([type isEqualToString:[NSString stringWithCString:@encode(BOOL)
//                                                                           encoding:NSUTF8StringEncoding]]) {
//                            void (*func)(id, SEL, BOOL) = (void *)imp;
//                            func(self, propertySetterSelector, [dicValue boolValue]);
//                        }else {
//                            DMLOG_ERROR(@"unhandled type:%@",type);
//                        }
//                    }else {
//                        DMLOG_ERROR(@"Inconsistency With Property:%@ Returned Type:%@",propertyName,NSStringFromClass([value class]));
//                    }
//                }
//            }
//
//        }
//    }
//    free(popertylist);
//    popertylist = NULL;
//}
//
//-(NSString *)misMatchProperty:(NSString *)propertyName
//{
//    if ([propertyName isEqualToString:@"default"]) {
//        return @"isDefault";
//    }
//    return propertyName;
//}
//
//- (SEL) setterSelectorForPropertyName:(NSString *)propertyName {
//    NSString * capitalizedPropertyName = [propertyName stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[propertyName substringToIndex:1] capitalizedString]];
//    NSString * methodString = [NSString stringWithFormat:@"set%@:", capitalizedPropertyName];
//    SEL propertySetterSelector = NSSelectorFromString(methodString);
//    return propertySetterSelector;
//}
//
//-(id)copyWithZone:(NSZone *)zone
//{
//    BaseModel *clone = [[[self class] allocWithZone:zone] init];
//    return clone;
//}
//




