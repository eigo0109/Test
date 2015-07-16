//
//  ViewController.m
//  Test
//
//  Created by qiandong on 7/8/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "ViewController.h"
#import "ApiManager.h"
#import "Fund.h"
#import "ESSession.h"
#import <CoreText/CoreText.h>
#import "Bostring.h"
#import "ApiTest.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UILabel *label;
- (IBAction)clicked:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
//    [ApiTest run];
    
    
    
   
    
    

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clicked:(id)sender {
//    [ApiTest runAfterLogin];
}

//-(void)doe
//{
//    
//    UIScrollView *topScrollView = [[UIScrollView alloc] init];
//    [topScrollView setBackgroundColor:[UIColor grayColor]];
//    topScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-UI_TOOL_BAR_HEIGHT +100);
//    [self.view addSubview:topScrollView];
//    
//    UILabel *label1 = [[UILabel alloc] init];
//    [label1 setBackgroundColor:[UIColor redColor]];
//    [label1 setText:@"111111"];
//    [topScrollView addSubview:label1];
//    
//    UIScrollView *bottomScrollView = [[UIScrollView alloc] init];
//    [bottomScrollView setBackgroundColor:[UIColor lightGrayColor]];
//    topScrollView.contentSize = CGSizeMake(UI_SCREEN_WIDTH, (UI_SCREEN_HEIGHT-UI_TOOL_BAR_HEIGHT)*2 +100);
//    [self.view addSubview:bottomScrollView];
//    
//    UILabel *label2 = [[UILabel alloc] init];
//    [label2 setBackgroundColor:[UIColor redColor]];
//    [label2 setText:@"222222"];
//    [bottomScrollView addSubview:label2];
//    
//    
//    [topScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-UI_TOOL_BAR_HEIGHT));
//        make.center.equalTo(CGPointMake(0, -UI_TOOL_BAR_HEIGHT/2));
//        
//    }];
//    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@50);
//        make.left.equalTo(topScrollView.left);
//        make.top.equalTo(topScrollView.top);
//        make.right.equalTo(topScrollView.right);
//    }];
//    
//    
//    
//    
//    [bottomScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.size.equalTo(CGSizeMake(UI_SCREEN_WIDTH, (UI_SCREEN_HEIGHT-UI_TOOL_BAR_HEIGHT)*2));
//        make.center.equalTo(CGPointMake(0, UI_SCREEN_HEIGHT/2-UI_TOOL_BAR_HEIGHT+UI_SCREEN_HEIGHT-UI_TOOL_BAR_HEIGHT));
//    }];
//    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.equalTo(@50);
//        make.left.equalTo(bottomScrollView.left);
//        make.top.equalTo(bottomScrollView.top);
//        make.right.equalTo(bottomScrollView.right);
//    }];
//}

@end
