//
//  CellTwo.m
//  MVC
//
//  Created by Wolf on 16/3/10.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "CellTwo.h"

@interface CellTwo ()

@property (weak, nonatomic) IBOutlet UILabel *detailLabel;


@end

@implementation CellTwo

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"CellTwo" bundle:nil];
}


- (void)configData:(Model *)model
{
    _detailLabel.text = model.modelTwo.detail;
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
