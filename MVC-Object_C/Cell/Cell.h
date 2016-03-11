//
//  Cell.h
//  MVC
//
//  Created by Wolf on 16/3/9.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"

@interface Cell : UITableViewCell

@property (nonatomic, copy) void(^cellSelect)(NSString *name);


+ (UINib *)nib;

- (void)configData:(Model *)model;

@end
