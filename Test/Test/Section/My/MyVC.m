//
//  MyVC.m
//  mxsj
//
//  Created by qiandong on 15/7/6.
//  Copyright (c) 2015年 sunday. All rights reserved.
//

#import "MyVC.h"
#import "FundCollectionCell.h"
#import "Fund.h"
#import "UserInfoVC.h"

@interface MyVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.navigationItem.title = @"我的1";
    
    [self buildNavBar];

    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerNib:[FundCollectionCell nib] forCellWithReuseIdentifier:[FundCollectionCell identifier]];
}

#pragma mark - layoutSubviews
-(void)viewWillLayoutSubviews
{
    
    NSInteger cellCountPerRow = 2;
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout*)_collectionView.collectionViewLayout;
    CGFloat availableWidthForCells = CGRectGetWidth(_collectionView.frame) - flowLayout.sectionInset.left - flowLayout.sectionInset.right - flowLayout.minimumInteritemSpacing * (cellCountPerRow - 1);
    CGFloat cellWidth = availableWidthForCells / cellCountPerRow;
    flowLayout.itemSize = CGSizeMake(cellWidth, flowLayout.itemSize.height);
    NSLog(@"xxx:%f",flowLayout.minimumInteritemSpacing);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FundCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[FundCollectionCell identifier] forIndexPath:indexPath];
    cell.cellData = [[Fund alloc] init];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - build custom view
-(void)buildNavBar
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 18.5, 18.5);
    [rightBtn addTarget:self action:@selector(userInfo) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setBackgroundImage:[UIImage imageNamed:@"person_icon.png"] forState:UIControlStateNormal];
    rightBtn.showsTouchWhenHighlighted = YES;
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
}

#pragma mark - button action
-(void)userInfo
{
    UserInfoVC *vc = [[UserInfoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
