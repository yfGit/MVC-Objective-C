//
//  Store.h
//  MVC
//
//  Created by Wolf on 16/3/9.
//  Copyright © 2016年 许毓方. All rights reserved.
//  通过它来获取数据, 获取数据方式(下载, 本地, etc.)

#import <Foundation/Foundation.h>




@interface Store : NSObject


/**
 *  本地plist
 */
+ (NSArray *)fetchLocalDataWithPlistFileFullName:(NSString *)fileFullName;


/**
 *  网络请求获取数据,
 *
 *  @param url        url
 *  @param param      参数
 *  @param modelClass model的NSString
 *
 *  @return 解析完成的数据源数组
 */
+ (NSArray *)updateWithURl:(NSURL *)url param:(NSArray *)param modelClass:(Class)modelClass;



// 自定义category

@end
