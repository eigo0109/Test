//
//  CoverCell.h
//  Test
//
//  Created by qiandong on 15/7/7.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTableCell.h"

@class  Fund;
@interface FuncTableCell :  BaseTableCell

@property(nonatomic,strong) Fund *cellData;

+ (float)cellHeight:(Fund *)celldata;

@end
