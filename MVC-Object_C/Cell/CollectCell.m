//
//  CollectCell.m
//  MVC-Object_C
//
//  Created by Wolf on 16/3/21.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "CollectCell.h"

@interface CollectCell ()

@property (weak, nonatomic) IBOutlet UILabel *label;


@end


@implementation CollectCell

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"CollectCell" bundle:nil];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)config:(NSIndexPath *)idx
{
    _label.text = [NSString stringWithFormat:@"%ld - %ld",idx.section, idx.row];
}
@end
