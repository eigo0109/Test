//
//  LaunchEditOneVC.m
//  Test
//
//  Created by qiandong on 15/7/9.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import "LaunchEditOneVC.h"
#import "LaunchEditTwoVC.h"

@interface LaunchEditOneVC ()

@end

@implementation LaunchEditOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"发起";
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)nextBtnClicked:(id)sender {
    LaunchEditTwoVC *vc = [[LaunchEditTwoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
