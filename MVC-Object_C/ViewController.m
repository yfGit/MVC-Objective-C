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
     *  DataSource不关注cell的细节处理
     */
    

    
    // 通过VC 控制 cell显示和交互
    __weak typeof(self) weakSelf = self;
    ConfigCellBlock block = ^(id cell, id item, NSIndexPath *indexPath) {
        
        [cell configData:item];  // 更新CellUI , method一样直接调
    };
#pragma mark  单个类型的cell
    //    _dataSource = [[DataSource alloc] initWithItem:dataArr
    //                                    cellIdentifier:CellIdentifier
    //                                    configCellBlcok:block];
    
    
#pragma mark  分组cell
    NSDictionary *group = @{
                            CellTwoIdentifier   : @[@1, @2],
                            CellThreeIdentifier : @[@3]
                            };
    _dataSource = [[DataSource alloc] initWithItem:dataArr
                                   cellIdentifiers:@[CellTwoIdentifier,
                                                     CellThreeIdentifier ,
                                                     CellIdentifier]
                                            groups:group
                                   configCellBlcok:block];
    
#pragma mark 嵌套cell 见 DataSource.h
    
    
    
#pragma mark   appendix
    _dataSource.cellSelectionStyle = UITableViewCellSelectionStyleDefault; // 统一配置,优先级低
    _dataSource.headerArr = @[@"a", @"b", @"c", @"d"];
    _dataSource.footerArr = @[@"footer-a", @"footer-b", @"footer-c", @"footer-d"];
    _dataSource.sectionIndex = @[@"index-a", @"index-b", @"index-c", @"index-d"];
    
    
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
//    if ((indexPath.section == 0 && indexPath.row == 1)
//        || (indexPath.section == 1 && indexPath.row == 2))
//    {
//        return 126;
//    }else if ((indexPath.section == 0 && indexPath.row == 4)
//              || (indexPath.section == 1 && indexPath.row == 6))
//    {
//        return 120;
//    }
//    return 44;
    
    if (indexPath.section == 1 || indexPath.section == 2 ) {
        return 126;
    }else if (indexPath.section == 3){
        return 120;
    }
    return 44;
}

@end
