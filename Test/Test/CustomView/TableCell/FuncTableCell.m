//
//  CoverCell.m
//  Test
//
//  Created by qiandong on 15/7/7.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import "FuncTableCell.h"
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"
#import "GradientProgressView.h"

#import "Fund.h"

@interface FuncTableCell ()

@property (weak, nonatomic) IBOutlet UIImageView *coverImgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *typeImgView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *followCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *commentCountLabel;

@property (weak, nonatomic) IBOutlet UIView *progressViewBK;
@property (weak, nonatomic) IBOutlet UIView *proView;

@property (weak, nonatomic) IBOutlet UILabel *supportPersonCount;
@property (weak, nonatomic) IBOutlet UILabel *remainDayCount;
@property (weak, nonatomic) IBOutlet UILabel *hadMoney;
@property (weak, nonatomic) IBOutlet UILabel *targetMoney;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *trailingCons;

@end

@implementation FuncTableCell

//一般修改这个方法即可
- (void)refresh{
    _titleLabel.text = _cellData.name;
    


    [self setSupportPersonCountLabel];
    [self setHadMoneyLabel];
    [self setGoalMoneyLabel];
    [self setRemainDayLabel];

    
        //设置字符串【NSString】
    _followCountLabel.text = _cellData.follow_count;
    _commentCountLabel.text = _cellData.comment_count;
    [_coverImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",BASE_URL,_cellData.cover]] placeholderImage:[UIImage imageNamed:@"Home_BigImg.png"]];
//    _typeLabel.text = [[ESSession shared].fundCateDict valueForKey: _cellData.category_id];
    
    //    [_typeImgView sd_setImageWithURL:[NSURL URLWithString:[ESHelper absoluteUrl:_cellData.cover]] placeholderImage:nil];
    //    _dayNumLabel.text = _cellData.;
    
    float progress = [_cellData.has_money floatValue]/[_cellData.goal_money floatValue] > 0.02 ? [_cellData.has_money floatValue]/[_cellData.goal_money floatValue] : 0.02;
    _trailingCons.constant = UI_SCREEN_WIDTH*(1-progress);
}



//如果有多个数据model来源，就增加多个set****Data方法即可
- (void)setCellData:(Fund *)newData{
    if(_cellData != newData){
        _cellData = newData;
        [self refresh];
    }
}


+ (float)cellHeight:(Fund *)celldata
{
    return (319.0/375)*UI_SCREEN_WIDTH + (526-319);
}

#pragma mark - setup cell contentview
-(void)setSupportPersonCountLabel
{
    NSString *pureStr = [NSString stringWithFormat:@"%@人",_cellData.support_count];
    NSAttributedString *attrStr =  [pureStr bos_makeString:^(BOStringMaker *make) {
        make.foregroundColor([UIColor blackColor]);
        make.font([UIFont boldSystemFontOfSize:15]);
        
        make.each.regexpMatch(@"[0-9]+", NSRegularExpressionCaseInsensitive, ^{
            make.foregroundColor([UIColor blackColor]);
            make.font([UIFont fontWithName:@"HelveticaNeue-Bold" size:22]);
        });
    }];
    _supportPersonCount.attributedText = attrStr;
}

-(void)setHadMoneyLabel
{
    NSString *pureStr = [NSString stringWithFormat:@"已筹: ￥ %.0f",[_cellData.has_money floatValue]];
    NSAttributedString *attrStr =  [pureStr bos_makeString:^(BOStringMaker *make) {
        make.foregroundColor([UIColor blackColor]);
        make.font([UIFont boldSystemFontOfSize:15]);
        
        make.each.regexpMatch(@"[0-9]+", NSRegularExpressionCaseInsensitive, ^{
            make.foregroundColor([ESHelper colorWithHexString:@"FF1790"]);
            make.font([UIFont fontWithName:@"HelveticaNeue-Bold" size:22]);
        });
    }];
    _hadMoney.attributedText = attrStr;
}

-(void)setGoalMoneyLabel
{
    NSString *pureStr = [NSString stringWithFormat:@"目标: ￥ %.0f",[_cellData.goal_money floatValue]];
    NSAttributedString *attrStr =  [pureStr bos_makeString:^(BOStringMaker *make) {
        make.foregroundColor([UIColor blackColor]);
        make.font([UIFont boldSystemFontOfSize:15]);
        
        make.each.regexpMatch(@"[0-9]+", NSRegularExpressionCaseInsensitive, ^{
            make.foregroundColor([ESHelper colorWithHexString:@"FF1790"]);
            make.font([UIFont fontWithName:@"HelveticaNeue-Bold" size:22]);
        });
    }];
    _targetMoney.attributedText = attrStr;
}

-(void)setRemainDayLabel
{
    NSString *pureStr = nil;
    NSAttributedString *attrString = nil;
    BOOL isEnd = NO;
    NSDateComponents *interval = [ESHelper intervalWithLate:_cellData.endtime Early:[NSDate date]];
    if (interval.day > 0) {
        pureStr = [NSString stringWithFormat:@"%li天",interval.day]; //day
    }else if(interval.hour > 0){
        pureStr = [NSString stringWithFormat:@"%li小时",interval.hour]; //Hour
    }else if(interval.minute > 0){
        pureStr = [NSString stringWithFormat:@"%li分钟",interval.minute]; //minute
    }else{
        isEnd = YES;
        pureStr = @"已结束"; //已结束
    }
    if (isEnd) {
        attrString = [pureStr bos_makeString:^(BOStringMaker *make) {
            make.foregroundColor([UIColor redColor]);
            make.font([UIFont boldSystemFontOfSize:20]);
        }];
    }else{
        attrString = [pureStr bos_makeString:^(BOStringMaker *make) {
            make.foregroundColor([UIColor blackColor]);
            make.font([UIFont boldSystemFontOfSize:15]);
            
            make.each.regexpMatch(@"[0-9]+", NSRegularExpressionCaseInsensitive, ^{
                make.foregroundColor([UIColor blackColor]);
                make.font([UIFont fontWithName:@"HelveticaNeue-Bold" size:22]);
            });
        }];
    }
    _remainDayCount.attributedText = attrString;
}



@end
