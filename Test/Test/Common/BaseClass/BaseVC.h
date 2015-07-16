//
//  BaseVC.h
//  mlh
//
//  Created by qd on 13-5-10.
//  Copyright (c) 2013年 sunday. All rights reserved.
//

#import <UIKit/UIKit.h>


//视图基类：全局统一的navigation bar，可设置navTitle，统一的导航条左按钮方法（子类可Overwrite）
@interface BaseVC : UIViewController


@property (nonatomic,assign)  float topDistance;

//@property (nonatomic, strong) UILabel *navTitleLabel;
//@property (nonatomic, strong) NSString * navTitle;
//@property (nonatomic, strong) UIButton *leftButton;

-(void)LeftAction:(id)sender;

@end
