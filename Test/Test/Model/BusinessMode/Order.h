//
//  Order.h
//  Test
//
//  Created by qiandong on 7/9/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

//id	Int	订单编号
//dream_id	Int	众筹ID
//goods_id	Int	商品ID
//goods_name	String	商品名称
//dream_data	String	众筹JSON数据
//price	Int	单价
//count	Int	数量
//address	Json	地址信息 参考用户地址接口数据格式
//payment_type	Int	付款方式 1支付宝 2微信
//dateline	Int	订单时间戳
#import "BaseModel.h"

@class Fund,Address;
@interface Order : BaseModel

@property(nonatomic,copy) NSString *dream_id;
@property(nonatomic,copy) NSString *goods_id;
@property(nonatomic,copy) NSString *goods_name;
@property(nonatomic,strong) Fund *dream_data;
@property(nonatomic,copy) NSString *price;
@property(nonatomic,strong) Address *address;
@property(nonatomic,copy) NSString *payment_type;
@property(nonatomic,copy) NSDate *dateline;


@end
