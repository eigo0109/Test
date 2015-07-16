//
//  Info.h
//  Test
//
//  Created by qiandong on 7/8/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//


//id	Int	众筹ID
//category_id	Int	分类ID
//city_id	Int	城市ID
//username	String	发布者昵称
//name	String	众筹名称
//cover	String	众筹封面URL 资源URL+此值
//video	String	视频代码 由请求参数 detail 控制是否返回
//summary	Text	摘要 文本
//content	Text	详情 HTML 由请求参数 detail 控制是否返回
//goal_money	Int	目标筹款金额
//has_money	Int	已筹集金额
//endtime	Int	结束时间戳 如 1429102346
//support_count	Int	支持数(实际购买)
//follow_count	Int	关注数
//like_count	Int	点赞数
//comment_count	Int	评论数
//dateline	Int	发布时间戳
#import "BaseModel.h"

@interface Fund : BaseModel

@property(nonatomic,copy) NSString *category_id;
@property(nonatomic,copy) NSString *city_id;
@property(nonatomic,copy) NSString *username;
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *cover;
@property(nonatomic,copy) NSString *video;
@property(nonatomic,copy) NSString *summary;
@property(nonatomic,copy) NSString *content;
@property(nonatomic,copy) NSString *goal_money;
@property(nonatomic,copy) NSString *has_money;
@property(nonatomic,copy) NSDate *endtime;
@property(nonatomic,copy) NSString *support_count;
@property(nonatomic,copy) NSString *follow_count;
@property(nonatomic,copy) NSString *like_count;
@property(nonatomic,copy) NSString *comment_count;
@property(nonatomic,copy) NSDate *dateline;

@end
