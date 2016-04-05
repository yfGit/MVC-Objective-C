//
//  CollectCellTwo.m
//  MVC-Object_C
//
//  Created by Wolf on 16/3/21.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "CollectCellTwo.h"

@interface CollectCellTwo ()

@property (weak, nonatomic) IBOutlet UILabel *label;


@end

@implementation CollectCellTwo


+ (UINib *)nib
{
    return [UINib nibWithNibName:@"CollectCellTwo" bundle:nil];
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)config:(NSIndexPath *)idx
{
    _label.text = [NSString stringWithFormat:@"%ld - %ld",idx.section, idx.row];
}

@end
