//
//  HomeVC.m
//  mxsj
//
//  Created by qiandong on 15/7/6.
//  Copyright (c) 2015年 sunday. All rights reserved.
//

#import "FundListVC.h"
#import "FuncTableCell.h"
#import "ApiManager.h"

#import "FundDetailVC.h"

@interface FundListVC () <UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSArray *_dataArray;
}
@end

@implementation FundListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @ "梦想世界2";
    
    _dataArray = [NSArray array];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT)];
    _tableView.showsHorizontalScrollIndicator = NO;
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    [_tableView registerNib:[FuncTableCell nib] forCellReuseIdentifier:[FuncTableCell identifier]];
    [_tableView setTableFooterView:[UIView new]];
    
    [self loadData];
}

-(void)loadData
{
    [[ApiManager shared] queryFundListWithCityId:nil
                                      categoryId:nil
                                            page:nil
                                           limit:nil
                                          detail:nil
                                           block:^(CommonResult *commonResult, NSArray *funds, NSError *error) {
                                               if (!error) {
                                                   if(commonResult.success){
                                                       _dataArray = [NSArray arrayWithArray:funds];
                                                       [_tableView reloadData];
                                                   }
                                               }else{
                                                   ;
                                               }
                                           }];

}

#pragma mark -
#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FuncTableCell *cell = [tableView dequeueReusableCellWithIdentifier:[FuncTableCell identifier] forIndexPath:indexPath];
    if (!cell){
        cell = [[FuncTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FuncTableCell identifier]];
    }
    Fund *entity = [_dataArray objectAtIndex:indexPath.row];
    cell.cellData = entity;
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Fund *entity = [_dataArray objectAtIndex:indexPath.row];
    return [FuncTableCell cellHeight:entity];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FundDetailVC *vc = [[FundDetailVC alloc] initWithNibName:@"FundDetailVC" bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
