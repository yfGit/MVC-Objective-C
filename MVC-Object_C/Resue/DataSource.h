//
//  DataSource.h
//  MVC
//
//  Created by Wolf on 16/3/9.
//  Copyright © 2016年 许毓方. All rights reserved.
//  通过它来配置Cell, TableView的DataSource,

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>






@interface DataSource : NSObject <UITableViewDataSource>

#pragma mark - Block
// viewcontroller 去配置 cell

typedef void (^ConfigCellBlock)(id cell, id item);



#pragma mark - Property

/** cell状态全局,优先级低于回调 */
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;

/** Header-title */
@property (nonatomic, strong) NSArray *headerArr;
/** Footer-title */
@property (nonatomic, strong) NSArray *footerArr;
/** section索引 */
@property (nonatomic, strong) NSArray *sectionIndex;



#pragma mark - Init

/**
 *  统一 cell 的初始化
 *
 *  @param item             数据源
 *  @param aCellIdentifier  cellId
 *  @param aConfigCellBlcok vc控制cell显示
 */
- (instancetype)initWithItem:(NSArray *)item
              cellIdentifier:(NSString *)aCellIdentifier
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok;



/**
 *  分组cell
 *
 *  @param aCellIdentifiers cellId 数组,
 *                           !!!最多使用到的cellId放最后
 *
 *  @param groups           cellId和IndexPath之间的关系,
 *                           !!!cellId数组最后一个cell对应关系不用写
 *
 */
- (instancetype)initWithItem:(NSArray *)item
             cellIdentifiers:(NSArray *)aCellIdentifiers
                      groups:(NSDictionary *)groups
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok;


/**
 *  嵌套 cell
 *
 *  @param aCellIdentifiers  cellId 数组,
 *                           !!!最多使用到的cellId放最后
 *
 *  @param relateDict        cellId和IndexPath之间的关系,
 *                           !!!最多使用到的cellId关系不用写
 *
 */
- (instancetype)initWithItem:(NSArray *)item
             cellIdentifiers:(NSArray *)aCellIdentifiers
         cellRelateIndexPath:(NSDictionary *)relateDict
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok;




#pragma mark - Method

/**
 *  viewcontroller 需要的当前cell数据 ( Delegate时 )
 */
- (id)itemForIndexPath:(NSIndexPath *)indexPath;


/**
 *  更新数据源
 */
- (void)reloadData:(NSArray *)dataArr;






#pragma mark - Usage
#pragma mark
#pragma mark  Cell-Block
/*
 
 ConfigCellBlock block = ^(id cell, id item) {
 
    if ([cell isKindOfClass:[UITableViewCell class]]) {
        UITableViewCell *configCell = (UITableViewCell *)cell;
        configCell.selectionStyle = UITableViewCellSelectionStyleNone; // 统一配置,优先级比属性高
    }
 
    [cell configData:item];  // 更新CellUI , method一样直接调
 
    if ([cell isKindOfClass:[Cell class]]) {
        Cell *cellOne = cell;
        cellOne.selectionStyle = UITableViewCellSelectionStyleNone;  // 单独配置,优先级比属性高
        cellOne.cellSelect = ^(NSString *name){
        LBLog(@"name : %@",name);
        };
    }else if ([cell isKindOfClass:[CellThree class]]) {
        CellThree *cellThree = cell;
        cellThree.cellSelect = ^(UIImage *img){
        LBLog(@"%@",img);
        };
    }
 };
 
 */

#pragma mark  Normal
/*
 _dataSource = [[DataSource alloc] initWithItem:dataArr
                                 cellIdentifier:CellIdentifier
                                configCellBlcok:^(id cell, id item) {
                                    [cell configData:item];
                                }];
*/


#pragma mark  Section
/*
 NSDictionary *group = @{
                        CellTwoIdentifier : @[@1, @3, @5]
                        };
 _dataSource = [[DataSource alloc] initWithItem:dataArr
                                cellIdentifiers:@[CellTwoIdentifier, CellIdentifier]
                                         groups:group
                                configCellBlcok:block];
 
 
*/



#pragma mark  Nest
/*
 
 // 对应的indexPath 和cell的关系
 NSIndexPath *indexPath1 = [NSIndexPath indexPathForRow:1 inSection:0];
 NSIndexPath *indexPath2 = [NSIndexPath indexPathForRow:2 inSection:1];
 NSArray *cellTwoIndexPaths = @[indexPath1, indexPath2];
 
 
 NSIndexPath *indexPath11 = [NSIndexPath indexPathForRow:4 inSection:0];
 NSIndexPath *indexPath22 = [NSIndexPath indexPathForRow:6 inSection:1];
 NSArray *cellThreeIndexPaths = @[indexPath11, indexPath22];
 
 NSDictionary *dict = @{
                        CellTwoIdentifier   : cellTwoIndexPaths,
                        CellThreeIdentifier : cellThreeIndexPaths
                      };
 
 // 初始化
 _dataSource = [[DataSource alloc] initWithItem:dataArr
                                cellIdentifiers:@[CellTwoIdentifier, CellThreeIdentifier, CellIdentifier]
                            cellRelateIndexPath:dict
                                configCellBlcok:block];
*/













@end
