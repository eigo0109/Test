//
//  CategoryVC.m
//  mxsj
//
//  Created by qiandong on 15/7/6.
//  Copyright (c) 2015年 sunday. All rights reserved.
//

#import "CategoryVC.h"
#import "CategoryCollectionCell.h"
#import "FundListVC.h"

@interface CategoryVC () <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    __weak IBOutlet UICollectionView *_collectionView;
}

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.title = @"分类";
    
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[CategoryCollectionCell nib] forCellWithReuseIdentifier:[CategoryCollectionCell identifier]];
}

#pragma mark - layoutSubviews
-(void)viewWillLayoutSubviews
{
    NSInteger cellCountPerRow = 2;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)_collectionView.collectionViewLayout;
    CGFloat availableWidthForCells = CGRectGetWidth(_collectionView.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (cellCountPerRow - 1);
    CGFloat cellWidth = availableWidthForCells / cellCountPerRow;
    flowLayout.itemSize = CGSizeMake(cellWidth, flowLayout.itemSize.height);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [ESSession shared].systemInfo.categoryList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CategoryCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[CategoryCollectionCell identifier] forIndexPath:indexPath];
    FundCategory *category = [[ESSession shared].systemInfo.categoryList objectAtIndex:indexPath.row];
    cell.cellData = category;
    return cell;
}


#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    FundListVC *vc = [[FundListVC alloc] init];
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
