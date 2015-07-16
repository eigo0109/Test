//
//  PopVC.m
//  Test
//
//  Created by qiandong on 7/16/15.
//  Copyright (c) 2015 qiandong. All rights reserved.
//

#import "PopVC.h"

#import "CSCell.h"
#import "CSSectionHeader.h"
#import "CSStickyHeaderFlowLayout.h"

@interface PopVC ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic, strong) NSArray *sections;
@property (nonatomic, strong) UINib *headerNib;

@end

@implementation PopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.sections = @[
                      @"Twitter1",
                      @"Twitter2",
                      @"Twitter3",
                      @"Twitter4",
                      @"Twitter5",
                      @"Twitter6",
                      @"Twitter7",
                      @"Twitter8",
                      @"Twitter9",
                      @"Twitter0",
                      @"Twitter1",
                      @"Twitter2",
                      @"Twitter3",
                      @"Twitter4",
                      @"Twitter5",
                      @"Twitter6",
                      @"Twitter7",
                      @"Twitter8",
                      @"Twitter9",
                      @"Twitter0",
                      ];
 NSLog(@"xxx%f",self.view.frame.size.width);
    [self reloadLayout];
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    [self.collectionView setBackgroundColor:[UIColor lightGrayColor]];
    self.collectionView.scrollIndicatorInsets = UIEdgeInsetsMake(44, 0, 0, 0);
    
//    self.headerNib = [UINib nibWithNibName:@"CSAlwaysOnTopHeader" bundle:nil];
    self.headerNib = [UINib nibWithNibName:@"CSGrowHeader" bundle:nil];
    
    
    [self.collectionView registerNib:self.headerNib
          forSupplementaryViewOfKind:CSStickyHeaderParallaxHeader
                 withReuseIdentifier:@"header"];
    
    //注册
    [self.collectionView registerClass:[CSCell class]forCellWithReuseIdentifier:@"cell"];
    
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.view addSubview:self.collectionView];
    
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    
    
}

- (void)reloadLayout {
    CSStickyHeaderFlowLayout *layout = (id)self.collectionView.collectionViewLayout;
    
//    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
//        layout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 200);
//        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 100);
//        layout.itemSize = CGSizeMake(self.view.frame.size.width, layout.itemSize.height);
//        // If we want to disable the sticky header effect
//        layout.disableStickyHeaders = YES;
//    }
   
    
    if ([layout isKindOfClass:[CSStickyHeaderFlowLayout class]]) {
        layout.parallaxHeaderReferenceSize = CGSizeMake(UI_SCREEN_WIDTH, UI_SCREEN_HEIGHT);
        layout.parallaxHeaderMinimumReferenceSize = CGSizeMake(UI_SCREEN_WIDTH, 250);
        layout.itemSize = CGSizeMake(self.view.frame.size.width, layout.itemSize.height);
        layout.parallaxHeaderAlwaysOnTop = NO;
        
        // If we want to disable the sticky header effect
        layout.disableStickyHeaders = YES;
    }
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [self reloadLayout];
}

#pragma mark UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _sections.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CSCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                             forIndexPath:indexPath];
    
    cell.textLabel.text = self.sections[indexPath.row];
    
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        
        CSSectionHeader *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                   withReuseIdentifier:@"sectionHeader"
                                                                          forIndexPath:indexPath];
        
        cell.textLabel.text = self.sections[indexPath.row];
        
        return cell;
    } else if ([kind isEqualToString:CSStickyHeaderParallaxHeader]) {
        UICollectionReusableView *cell = [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                                                            withReuseIdentifier:@"header"
                                                                                   forIndexPath:indexPath];
        
        return cell;
    }
    return nil;
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
