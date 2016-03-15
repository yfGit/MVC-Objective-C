//
//  Store.m
//  MVC
//
//  Created by Wolf on 16/3/9.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "Store.h"
#import "Model.h"
#import "MJExtension.h"

@implementation Store


+ (NSArray *)fetchLocalDataWithPlistFileFullName:(NSString *)fileFullName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:fileFullName ofType:nil];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSMutableArray *data = [NSMutableArray array];
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i < [dict[@"Data"] count]; i++) {
        Model *model = [Model mj_objectWithKeyValues:dict[@"Data"][i]];
        [arr addObject:model];
    }
    [data addObject:arr];
    
    arr = [NSMutableArray array];
    for (int i = 0; i < [dict[@"Data2"] count]; i++) {
        Model *model = [Model mj_objectWithKeyValues:dict[@"Data2"][i]];
        [arr addObject:model];
    }
    [data addObject:arr];
    
    
    arr = [NSMutableArray array];
    for (int i = 0; i < [dict[@"Data3"] count]; i++) {
        Model *model = [Model mj_objectWithKeyValues:dict[@"Data2"][i]];
        [arr addObject:model];
    }
    [data addObject:arr];
    
    arr = [NSMutableArray array];
    for (int i = 0; i < [dict[@"Data4"] count]; i++) {
        Model *model = [Model mj_objectWithKeyValues:dict[@"Data2"][i]];
        [arr addObject:model];
    }
    [data addObject:arr];
    
    return data;
}


// 数组的话, 和后台沟通好统一字典的key
+ (NSArray *)updateWithURl:(NSURL *)url param:(NSArray *)param modelClass:(Class)modelClass
{
    
    // 模拟请求回来的数组
    NSMutableArray *data2 = [NSMutableArray array];
    id model = [[modelClass alloc] init];
    
    if (model == nil) {
        return nil;
    }
    
    
    if (model) {
        
        NSDictionary *dict = @{
                               @"name":@"Rose",
                               @"age" :@"31",
                               @"modelTwo" : @{
                                               @"detail": @"调试cocoa程序在程序出错时，不会马上停止。使用宏NSAssert可以让程序出错时马上抛出异常"
                                            },
                               @"modelThree" : @{
                                                @"picUrl":@"http://d05.res.meilishuo.net/pic/_o/62/23/f8acd1aeeca8a80b5a9960a97910_800_800.c8.jpeg"
                                            }
                               };
        
        model = [modelClass mj_objectWithKeyValues:dict];
        [data2 addObject:model];
        [data2 addObject:model];
        [data2 addObject:model];
        [data2 addObject:model];
        [data2 addObject:model];
        return data2;
    }
    
    return nil;
}




@end
