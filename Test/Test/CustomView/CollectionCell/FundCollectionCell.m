//
//  FundCollectionCell.m
//  Test
//
//  Created by qiandong on 15/7/11.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import "FundCollectionCell.h"

@interface FundCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImgView;
@property (weak, nonatomic) IBOutlet UIImageView *statsImgView;

@end

@implementation FundCollectionCell

//一般修改这个方法即可
- (void)refresh{
    //    _titleLabel.text = _cellData.name;
    [_bgImgView setImage:[UIImage imageNamed:@"fund_sample.png"]];
    [_statsImgView setImage:[UIImage imageNamed:@"fund_over.png"]];
}

//如果有多个数据model来源，就增加多个set****Data方法即可
- (void)setCellData:(Fund *)newData{
    if(_cellData != newData){
        _cellData = newData;
        [self refresh];
    }
}

@end
