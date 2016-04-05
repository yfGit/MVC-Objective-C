//
//  SectionHeader.m
//  MVC-Object_C
//
//  Created by Wolf on 16/4/5.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "SectionHeader.h"

@implementation SectionHeader

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"SectionHeader" bundle:nil];
}

- (void)awakeFromNib {
    [super awakeFromNib];
}
- (IBAction)click:(id)sender {
    NSLog(@"%s",__func__);
}

@end
