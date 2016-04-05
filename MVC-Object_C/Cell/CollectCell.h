//
//  CollectCell.h
//  MVC-Object_C
//
//  Created by Wolf on 16/3/21.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CollectCell : UICollectionViewCell
+ (UINib *)nib;

- (void)config:(NSIndexPath *)idx;

@end
