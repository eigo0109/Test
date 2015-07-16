//
//  UserInfoVC.m
//  Test
//
//  Created by qiandong on 15/7/11.
//  Copyright (c) 2015年 qiandong. All rights reserved.
//

#import "UserInfoVC.h"

#define BIG_CELL_INDENTITY @"bigCellIndentity"
#define NORMAL_CELL_INDENTITY @"normalCellIndentity"

@interface UserInfoVC ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_tableView;
    NSArray *_sections;
}
@end

@implementation UserInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.title = @"个人资料";
    
    _sections = @[
                    @[@"我的头像"],
                    @[@"昵称",@"性别"],
                    @[@"我的订单",@"收货地址"],
                    @[@"手机号码",@"修改密码"],
                    @[@"关于我们",@"意见反馈"]
                ];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, UI_STATUS_BAR_HEIGHT+UI_NAVIGATION_BAR_HEIGHT, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT-UI_STATUS_BAR_HEIGHT-UI_NAVIGATION_BAR_HEIGHT-UI_TAB_BAR_HEIGHT)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:BIG_CELL_INDENTITY];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NORMAL_CELL_INDENTITY];

    [_tableView reloadData];
}

#pragma mark -
#pragma mark - UITableViewDataSource

#pragma mark TableView...

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = _sections[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIndentity = nil;
    if (indexPath.section == 0) {
        cellIndentity = BIG_CELL_INDENTITY;
    }else{
        cellIndentity = NORMAL_CELL_INDENTITY;
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIndentity];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndentity];
    }
    
    cell.textLabel.text = _sections[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        [self editAvatar];
    }
    if (indexPath.section == 0 && indexPath.row == 0) {
        [self editNickname];
    }
    if (indexPath.section == 0 && indexPath.row == 1) {
        [self editSex];
    }
    if (indexPath.section == 1 && indexPath.row == 0) {
        [self myOrder];
    }
    if (indexPath.section == 1 && indexPath.row == 1) {
        [self editAddress];
    }
    if (indexPath.section == 2 && indexPath.row == 0) {
        [self editMobile];
    }
    if (indexPath.section == 2 && indexPath.row == 1) {
        [self changePassword];
    }
    if (indexPath.section == 3 && indexPath.row == 0) {
        [self aboutUs];
    }
    if (indexPath.section == 3 && indexPath.row == 1) {
        [self advice];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return 10;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    return [UIView new];
//}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [UIView new];
}

-(void)editAvatar
{
    NSLog(@"editAvatar");
}

-(void)editNickname
{
    NSLog(@"editNickname");
}

-(void)editSex
{
    NSLog(@"editSex");
}

-(void)myOrder
{
    NSLog(@"myOrder");
}

-(void)editAddress
{
    NSLog(@"editAddress");
}

-(void)editMobile
{
    NSLog(@"editMobile");
}

-(void)changePassword
{
    NSLog(@"changePassword");
}

-(void)aboutUs
{
    NSLog(@"aboutUs");
}

-(void)advice
{
    NSLog(@"advice");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
