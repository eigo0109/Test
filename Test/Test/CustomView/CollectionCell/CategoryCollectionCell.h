//
//  CategoryCollectionCell.h
//  Test
//
//  Created by qiandong on 15/7/9.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import "BaseCollectionCell.h"

@class  FundCategory;
@interface CategoryCollectionCell : BaseCollectionCell

@property(nonatomic,strong) FundCategory *cellData;

@end
