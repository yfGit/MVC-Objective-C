//
//  Cell.m
//  MVC
//
//  Created by Wolf on 16/3/9.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "Cell.h"

@interface Cell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *ageLabel;


@end


@implementation Cell


+ (UINib *)nib
{
    return [UINib nibWithNibName:@"Cell" bundle:nil];
}


- (void)configData:(Model *)model
{
    _nameLabel.text = model.name;
    _ageLabel.text  = [NSString stringWithFormat:@"%d",model.age];
}


- (void)awakeFromNib {
    
    _nameLabel.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_nameLabel addGestureRecognizer:tap];
    
}

- (void)tap
{
    if (self.cellSelect) {
        self.cellSelect(_nameLabel.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}




@end
