//
//  ViewController.m
//  MVC-Object_C
//
//  Created by Wolf on 16/3/10.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "ViewController.h"
#import "DataSource.h"
#import "Cell.h"
#import "CellTwo.h"
#import "Store.h"
#import "MJRefresh.h"
#import "CellSelectController.h"
#import "Model.h"
#import "CellThree.h"

#define kScreenWidth    ([[UIScreen mainScreen] bounds].size.width)
#define kScreenHeight   ([[UIScreen mainScreen] bounds].size.height)

@interface ViewController ()<UITableViewDelegate>
{}

@property (nonatomic, strong) UITableView *tbView;

@property (nonatomic, strong) DataSource *dataSource;

@end

// cellId
static NSString * const CellIdentifier      = @"Cell";
static NSString * const CellTwoIdentifier   = @"CellTwo";
static NSString * const CellThreeIdentifier = @"CellThree";

@implementation ViewController

#pragma mark- Init
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MVC";
    
    [self setup];
    
}



#pragma mark- setup

- (void)setup
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    _tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) style:UITableViewStyleGrouped];
    [self.view addSubview:_tbView];
    _tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    
    
    
    // 获取数据
    // 本地
    NSArray *dataArr = [Store fetchLocalDataWithPlistFileFullName:@"LocalTest.plist"];
    // 请求
    //    NSArray *dataArr = [self fetchData];
    
    
    /**
     *  viewcontroller 控制cell的显示, cell的交互
     *  DataSource不关注cell的细节处理,只要它们配置数据的方式相同
     */
    
#pragma mark  多种 cell
    
    // 通过VC 控制 cell显示和交互
    __weak typeof(self) weakSelf = self;
    ConfigCellBlock block = ^(id cell, id item) {
//        if ([cell isKindOfClass:[UITableViewCell class]]) {
//            UITableViewCell *configCell = (UITableViewCell *)cell;
//            configCell.selectionStyle = UITableViewCellSelectionStyleNone; // 统一配置,优先级比属性高
//        }
        
        
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
#pragma mark   单个类型的cell
//        _dataSource = [[DataSource alloc] initWithItem:dataArr
//                                        cellIdentifier:CellIdentifier
//                                       configCellBlcok:^(id cell, id item) {
//                                            [cell configData:item];
//                                       }];
    
#pragma mark   appendix
//    _dataSource.cellSelectionStyle = UITableViewCellSelectionStyleDefault; // 统一配置,优先级低
//    _dataSource.headerArr = @[@"a", @"b", @"c"];
//    _dataSource.footerArr = @[@"footer-a", @"footer-b", @"footer-c"];
//    _dataSource.sectionIndex = @[@"index-a", @"index-b", @"index-c"];
    
    
    _tbView.dataSource = _dataSource;
    _tbView.delegate   = self;
    [_tbView registerNib:[Cell nib] forCellReuseIdentifier:CellIdentifier];
    [_tbView registerNib:[CellTwo nib] forCellReuseIdentifier:CellTwoIdentifier];
    [_tbView registerNib:[CellThree nib] forCellReuseIdentifier:CellThreeIdentifier];
    
    // 更新数据
    _tbView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        NSArray *newData = [weakSelf fetchData];
        [weakSelf.dataSource reloadData:newData];
        [weakSelf.tbView reloadData];
        [_tbView.mj_header endRefreshing];
    }];
    
    
}

#pragma mark- updateData

- (NSArray *)fetchData
{
    NSArray *data = [Store updateWithURl:nil param:nil modelClass:[Model class]];
    return data;
}


#pragma mark- Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    id item = [_dataSource itemForIndexPath:indexPath];
    if ([item isKindOfClass:[Model class]]) {
        Model *model = (Model *)item;
        CellSelectController *vc = [[CellSelectController alloc] init];
        vc.name = model.name;
        vc.age  = [NSString stringWithFormat:@"%d",model.age];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ((indexPath.section == 0 && indexPath.row == 1)
        || (indexPath.section == 1 && indexPath.row == 2))
    {
        return 126;
    }else if ((indexPath.section == 0 && indexPath.row == 4)
              || (indexPath.section == 1 && indexPath.row == 6))
    {
        return 120;
    }
    return 44;
}

@end
