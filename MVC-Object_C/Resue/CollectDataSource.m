//
//  CollectDataSource.m
//  MVC-Object_C
//
//  Created by Wolf on 16/3/21.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "CollectDataSource.h"

@interface CollectDataSource ()
{}

@property (nonatomic, strong) NSArray *dataArr;

// 配置回调
@property (nonatomic, copy) ConfigCellBlock configCellBlcok;



// 单个cell
@property (nonatomic, assign) BOOL isNormalCell;
@property (nonatomic, copy) NSString *cellId;


@property (nonatomic, assign) BOOL isGroup;
@property (nonatomic, strong) NSArray *cellIds;
@property (nonatomic, strong) NSDictionary *gruops;



@end

@implementation CollectDataSource


#pragma mark- Init
- (instancetype)initWithItem:(NSArray *)item
              cellIdentifier:(NSString *)aCellIdentifier
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok;
{
    self = [super init];
    if (self) {

        if (![item[0] isKindOfClass:[NSArray class]]) return nil;
        
        _dataArr = item;
        _cellId  = aCellIdentifier;
        _configCellBlcok = aConfigCellBlcok;
        _isNormalCell = YES;
    }
    return self;
}

- (instancetype)initWithItem:(NSArray *)item
             cellIdentifiers:(NSArray *)aCellIdentifiers
                      groups:(NSDictionary *)groups
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok
{
    self = [super init];
    if (self) {
        
        if (![item[0] isKindOfClass:[NSArray class]]) return nil;
        
        _isGroup = YES;
        _dataArr = item;
        _gruops  = groups;
        _cellIds = aCellIdentifiers;
        _configCellBlcok = aConfigCellBlcok;
    }
    return self;
}


#pragma mark- Method
- (id)itemForIndexPath:(NSIndexPath *)indexPath
{
    id item = _dataArr[indexPath.section][indexPath.row];
    return item;
}

- (void)reloadData:(NSArray *)dataArr
{
    if (![dataArr[0] isKindOfClass:[NSArray class]]) return;
    
    _dataArr = dataArr;
}


#pragma mark- DataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArr[section] count];
}



- (UICollectionViewCell *)normalCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:_cellId forIndexPath:indexPath];
    
    id item = [self itemForIndexPath:indexPath];
    if (self.configCellBlcok) {
        self.configCellBlcok(cell, item, indexPath);
    }
    
    return cell;
    
}

- (UICollectionViewCell *)groupCollectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i = 0; i < _cellIds.count-1; i++) {
        NSString *cellId = _cellIds[i];
        for (NSNumber *num in _gruops[cellId]) {
            if (num.integerValue == indexPath.section) {
                
                UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId forIndexPath:indexPath];
                
                
                
                id item = [self itemForIndexPath:indexPath];
                if (self.configCellBlcok) {
                    self.configCellBlcok(cell, item, indexPath);
                }
                return cell;
            }
        }
    }
    
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[_cellIds lastObject] forIndexPath:indexPath];
    
    id item = [self itemForIndexPath:indexPath];
    if (self.configCellBlcok) {
        self.configCellBlcok(cell, item, indexPath);
    }
    
    return cell;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isNormalCell) {
        return [self normalCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }else if (_isGroup) {
        return [self groupCollectionView:collectionView cellForItemAtIndexPath:indexPath];
    }
    return nil;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader) {

        if (_sectionHeaderIdentifer) {
            UICollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:_sectionHeaderIdentifer forIndexPath:indexPath];
            return header;
        }
    }else if (kind == UICollectionElementKindSectionFooter) {

        if (_sectionFooterIdentifer) {
            UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:_sectionFooterIdentifer forIndexPath:indexPath];
            return footer;
        }
    }
    return nil;
}


- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath
{
     return YES;
}

- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath*)destinationIndexPath
{
    NSLog(@"%s",__func__);
}
 


@end
