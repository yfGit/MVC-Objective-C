//
//  CollectDataSource.h
//  MVC-Object_C
//
//  Created by Wolf on 16/3/21.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CollectDataSource : NSObject <UICollectionViewDataSource>

#pragma mark - Block

// viewcontroller 去配置 cell
typedef void (^ConfigCellBlock)(id cell, id item, NSIndexPath *idx);

@property (nonatomic, copy) NSString *sectionHeaderIdentifer;
@property (nonatomic, copy) NSString *sectionFooterIdentifer;

#pragma mark - Init
// 同DataSource

/** Normal */
- (instancetype)initWithItem:(NSArray *)item
              cellIdentifier:(NSString *)aCellIdentifier
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok;

/** Group */
- (instancetype)initWithItem:(NSArray *)item
             cellIdentifiers:(NSArray *)aCellIdentifiers
                      groups:(NSDictionary *)groups
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



@end
