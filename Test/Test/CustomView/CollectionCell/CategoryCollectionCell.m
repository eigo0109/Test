//
//  CategoryCollectionCell.m
//  Test
//
//  Created by qiandong on 15/7/9.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import "CategoryCollectionCell.h"

@interface CategoryCollectionCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation CategoryCollectionCell

//一般修改这个方法即可
- (void)refresh{
//    _titleLabel.text = _cellData.name;
    [_imgView setImage:[UIImage imageNamed:@"cate_sample.png"]];
}

//如果有多个数据model来源，就增加多个set****Data方法即可
- (void)setCellData:(FundCategory *)newData{
    if(_cellData != newData){
        _cellData = newData;
        [self refresh];
    }
}

@end
