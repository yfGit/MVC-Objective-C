//
//  DataSource.m
//  MVC
//
//  Created by Wolf on 16/3/9.
//  Copyright © 2016年 许毓方. All rights reserved.
//





#import "DataSource.h"

@interface DataSource ()
{}

@property (nonatomic, strong) NSArray *dataArr;

// 单个cell
@property (nonatomic, copy) NSString *cellId;
@property (nonatomic, assign) BOOL isNormalCell;

// 多种cell
@property (nonatomic, strong) NSArray *cellIds;
@property (nonatomic, strong) NSDictionary *relateDict;

// 配置回调
@property (nonatomic, copy) ConfigCellBlock configCellBlcok;

/** 二维数组 */
@property (nonatomic, assign) BOOL isTwoDimension;



@end


@implementation DataSource

#pragma mark- Init

- (instancetype)initWithItem:(NSArray *)item
              cellIdentifier:(NSString *)aCellIdentifier
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok
{
    self = [super init];
    if (self) {
        
        if (item == nil)
            LBLog(@"🐶 --> item == nil");
        else if (aConfigCellBlcok == nil)
            LBLog(@"🐶 --> aConfigCellBlcok == nil");
        _isNormalCell = YES;
        _dataArr = item;
        _cellId = aCellIdentifier;
        _configCellBlcok = [aConfigCellBlcok copy]; // 不用copy显示也正常
       
        if ([item[0] isKindOfClass:[NSArray class]]) { // 是否二维数组
            _isTwoDimension = YES;
        }
    }
    return self;
}

- (instancetype)initWithItem:(NSArray *)item
             cellIdentifiers:(NSArray *)aCellIdentifiers
         cellRelateIndexPath:(NSDictionary *)relateDict
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok
{
    self = [super init];
    if (self) {
        _dataArr = item;
        _cellIds = aCellIdentifiers;
        _configCellBlcok = aConfigCellBlcok;
        _relateDict = relateDict;
        if ([item[0] isKindOfClass:[NSArray class]]) { // 是否二维数组
            _isTwoDimension = YES;
        }

    }
    return self;
}




#pragma mark- Properties

- (void)setHeaderArr:(NSArray *)headerArr
{
    _headerArr = headerArr;
}

- (void)setFooterArr:(NSArray *)footerArr
{
    _footerArr = footerArr;
}

- (void)setSectionIndex:(NSArray *)sectionIndex
{
    _sectionIndex = sectionIndex;
}



#pragma mark- Method


/**
 *  获取cell的数据
 */
- (id)itemForIndexPath:(NSIndexPath *)indexPath
{
    id item;
    if (_isTwoDimension) {
        
        item = _dataArr[indexPath.section][indexPath.row];
    }else {
        item = _dataArr[indexPath.row];
    }
    
    return item;
}


/**
 *  更新数据源
 */
- (void)reloadData:(NSArray *)dataArr
{
    if (dataArr) {
        if ([dataArr[0] isKindOfClass:[NSArray class]]) { // 可能和初始化时不一样,不一样会crash
            _isTwoDimension = YES;
        }else {
            _isTwoDimension = NO;
        }
        _dataArr = dataArr;
    }
}

#pragma mark- DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_isTwoDimension) {
        return _dataArr.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_isTwoDimension) {
        return [_dataArr[section] count];
    }else {
        return _dataArr.count;
    }
}



- (UITableViewCell *)NormalTableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:_cellId forIndexPath:indexPath];
    
    id item = [self itemForIndexPath:indexPath];
    
    if (self.configCellBlcok) {
        self.configCellBlcok(cell, item);
    }
    
    return cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_isNormalCell) {
        return [self NormalTableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    
    for (int i = 0; i < _cellIds.count-1; i++) {
        NSString *cellId = _cellIds[i];
        
        for (id idxP in _relateDict[cellId]) {
            if ([idxP isKindOfClass:[NSIndexPath class]]) {
                NSIndexPath *idx = idxP;
                
                if (indexPath == idx) {
                    
                    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId forIndexPath:indexPath];
                    cell.selectionStyle = self.cellSelectionStyle;
                    
                    id item = [self itemForIndexPath:indexPath];
                    
                   
                    
                    
                    if (self.configCellBlcok) {
                        self.configCellBlcok(cell, item);
                    }
                    return cell;
                }
            }
        }
    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[_cellIds lastObject] forIndexPath:indexPath];
    id item = [self itemForIndexPath:indexPath];
    
    cell.selectionStyle = self.cellSelectionStyle;
    
    if (self.configCellBlcok) {
        self.configCellBlcok(cell, item);
    }

    return cell;
}


#pragma mark Header Footer

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (_headerArr)
        return  _headerArr[section];
    
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    if (_footerArr)
    return  _footerArr[section];
    
    return nil;
}


#pragma mark Edit

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO; // YES左滑编辑
}


#warning 多种cell编辑删除有点麻烦(下面有问题), 交换方式系统做了处理=.=
/**
 * 删除一个cell, deleteRowsAtIndexPaths 代理只会处理 要显示的cell
 *
 */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
       
        
        if (!_isNormalCell)  {  // 多种cell
            
            // 对比indexPath,调整indexPath
            for (NSInteger i = 0; i < _cellIds.count-1; i++) {
                NSString *cellId = _cellIds[i];
                NSMutableArray *cellIndexs = [NSMutableArray arrayWithArray:_relateDict[cellId]];
                for (int i = (int)cellIndexs.count-1; i >= 0; i--) {
                    if ([cellIndexs[i] isKindOfClass:[NSIndexPath class]]) {
                        NSIndexPath *idx = cellIndexs[i];
                        if (idx.section == indexPath.section && idx.row == indexPath.row) {
                            [cellIndexs removeObject:idx];
                        }else if (idx.section == indexPath.section && idx.row > indexPath.row) {
                            [cellIndexs removeObject:idx];
                            [cellIndexs addObject:indexPath];
                            idx = indexPath;
                        }
                    }
                }
                NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:_relateDict];
                [dict removeObjectForKey:cellId];
                [dict setObject:cellId forKey:cellIndexs];
                _relateDict = dict;
            }
        }
        
        NSMutableArray *arr = [NSMutableArray arrayWithArray:_dataArr];
        
        if (_isTwoDimension)
            [arr[indexPath.section] removeObjectAtIndex:indexPath.row];
        else
            [arr removeObjectAtIndex:indexPath.row];
        
        _dataArr = arr;
//        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}



- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES; // 出现移动的按钮
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // 限制移动
}



#pragma mark Index
- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    if (!_sectionIndex)  return nil;
    
    NSInteger count;
    if (_isTwoDimension) {
        count = _dataArr.count;
    }else {
        count = 1;
    }
    NSArray *arr = [_sectionIndex subarrayWithRange:NSMakeRange(0, count)];
    return arr;
    
}


- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    [tableView setEditing:!tableView.isEditing]; // 测试
    return index;
}

@end
