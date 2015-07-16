//
//  LaunchVC.m
//  mxsj
//
//  Created by qiandong on 15/7/6.
//  Copyright (c) 2015年 sunday. All rights reserved.
//

#import "LaunchVC.h"
#import "LaunchEditOneVC.h"

@interface LaunchVC ()


@end

@implementation LaunchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)launch:(id)sender {
    LaunchEditOneVC *vc = [[LaunchEditOneVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
@end
