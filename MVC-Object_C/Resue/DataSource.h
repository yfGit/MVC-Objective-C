//
//  DataSource.h
//  MVC
//
//  Created by Wolf on 16/3/9.
//  Copyright © 2016年 许毓方. All rights reserved.
//  通过它来配置Cell, TableView的DataSource,

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifdef DEBUG
#define LBLog(...)    NSLog(__VA_ARGS__)
#else
#define LBLog(...)
#endif


// viewcontroller 去配置 cell
typedef void (^ConfigCellBlock)(id cell, id item);


@interface DataSource : NSObject <UITableViewDataSource>





// appendix

/** cell状态全局,优先级低于回调 */
@property (nonatomic, assign) UITableViewCellSelectionStyle cellSelectionStyle;

/** Header-title */
@property (nonatomic, strong) NSArray *headerArr;
/** Footer-title */
@property (nonatomic, strong) NSArray *footerArr;
/** section索引 */
@property (nonatomic, strong) NSArray *sectionIndex;


/**
 *  cell统一的初始化
 *
 *  @param item             数据源
 *  @param aCellIdentifier  cellId
 *  @param aConfigCellBlcok vc控制cell显示
 */
- (instancetype)initWithItem:(NSArray *)item
              cellIdentifier:(NSString *)aCellIdentifier
             configCellBlcok:(ConfigCellBlock)aConfigCellBlcok;



/**
 *  cell 不同
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

/**
 *  viewcontroller 需要的当前cell数据 ( Delegate时 )
 */
- (id)itemForIndexPath:(NSIndexPath *)indexPath;


/**
 *  更新数据源
 */
- (void)reloadData:(NSArray *)dataArr;

@end
