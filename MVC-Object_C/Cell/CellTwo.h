//
//  CellTwo.h
//  MVC
//
//  Created by Wolf on 16/3/10.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
@interface CellTwo : UITableViewCell


+ (UINib *)nib;

- (void)configData:(Model *)model;

@end
