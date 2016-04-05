
//
//  CollectViewController.m
//  MVC-Object_C
//
//  Created by Wolf on 16/3/21.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "CollectViewController.h"
#import "CollectDataSource.h"
#import "CollectCell.h"
#import "CollectCellTwo.h"
#import "Store.h"
#import "MJRefresh.h"
#import "Model.h"
#import "SectionHeader.h"
#import "SectionFooter.h"

@interface CollectViewController ()<UICollectionViewDelegate>
{}

@property (nonatomic, strong) UICollectionView *collectView;

@property (nonatomic, strong) CollectDataSource *dataSource;

@end

@implementation CollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setup];
    
}

// cellId
static NSString * const CollectCellOneIdentifier  = @"CollectOneCell";
static NSString * const CollectCellTwoIdentifier  = @"CollectTwoCell";
static NSString * const CollectCellHeaderIdentifier  = @"CollectHeader";
static NSString * const CollectCellFooterIdentifier  = @"CollectFooter";

- (void)setup
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    float padding = 10;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(padding, padding, padding, padding);
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 10;
    layout.headerReferenceSize = CGSizeMake(100, 40);
    layout.footerReferenceSize = CGSizeMake(10, 20) ;
    float w = ([UIScreen mainScreen].bounds.size.width-5*padding)/4;
    
    layout.itemSize = CGSizeMake(w, w);
    
    _collectView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64) collectionViewLayout:layout];
    [self.view addSubview:_collectView];
    
    
    NSArray *arr = [Store fetchLocalDataWithPlistFileFullName:@"LocalTest.plist"];
/*
    _dataSource = [[CollectDataSource alloc] initWithItem:arr
                                           cellIdentifier:CollectCellOneIdentifier
                                          configCellBlcok:^(id cell, id item, NSIndexPath *idx) {
                                              [cell config:idx];
                                          }];
*/
    NSArray *cellIds = @[CollectCellTwoIdentifier, CollectCellOneIdentifier];
    NSDictionary *dict = @{CollectCellTwoIdentifier:@[@1,@3]} ;
    _dataSource = [[CollectDataSource alloc] initWithItem:arr
                                          cellIdentifiers:cellIds
                                                   groups:dict
                                          configCellBlcok:^(id cell, id item, NSIndexPath *idx) {
                                                       [cell config:idx];
                                                   }];

    _collectView.dataSource = self.dataSource;
    _collectView.delegate   = self;
    _collectView.backgroundColor = [UIColor colorWithRed:0.6 green:0.4 blue:0.2 alpha:0.229202586206897];
    _dataSource.sectionHeaderIdentifer = CollectCellHeaderIdentifier;
    _dataSource.sectionFooterIdentifer = CollectCellFooterIdentifier;
    

    [_collectView registerNib:[CollectCell nib] forCellWithReuseIdentifier:CollectCellOneIdentifier];
    [_collectView registerNib:[CollectCellTwo nib] forCellWithReuseIdentifier:CollectCellTwoIdentifier];
    [_collectView registerNib:[SectionHeader nib] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:CollectCellHeaderIdentifier];
    [_collectView registerNib:[SectionFooter nib] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:CollectCellFooterIdentifier];
    
    __weak typeof(self) weakSelf = self;
    _collectView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       
        NSMutableArray *arr = [NSMutableArray array];
        for (int i = 0; i < 2; i++) {
            NSArray *newData = [weakSelf fetchData];
            [arr addObject:newData];
        }
        [weakSelf.dataSource reloadData:arr];
        [weakSelf.collectView reloadData];
        [weakSelf.collectView.mj_header endRefreshing];
    }];

}

- (NSArray *)fetchData
{
    NSArray *data = [Store updateWithURl:nil param:nil modelClass:[Model class]];
    return data;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%ld - %ld",indexPath.section, indexPath.row);
}


@end
