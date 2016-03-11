//
//  Model.h
//  MVC
//
//  Created by Wolf on 16/3/9.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ModelTwo;
@class ModelThree;

@interface Model : NSObject

@property (nonatomic, copy)   NSString *name;
@property (nonatomic, assign) int age;
@property (nonatomic, strong) ModelTwo *modelTwo;
@property (nonatomic, strong) ModelThree *modelThree;

@end


@interface ModelTwo : NSObject

@property (nonatomic, strong) NSString *detail;

@end



@interface ModelThree : NSObject

@property (nonatomic, copy) NSString *picUrl;

@end