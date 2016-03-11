//
//  CellThree.m
//  MVC
//
//  Created by Wolf on 16/3/10.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "CellThree.h"
#import "UIImageView+WebCache.h"

@interface CellThree ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;


@end

@implementation CellThree

+ (UINib *)nib
{
    return [UINib nibWithNibName:@"CellThree" bundle:nil];
}


- (void)configData:(Model *)model
{
    NSURL *url = [NSURL URLWithString:model.modelThree.picUrl];
    [_imgView sd_setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
}



- (void)awakeFromNib {
    
    _imgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
    [_imgView addGestureRecognizer:tap];
}

- (void)tap
{
    if (self.cellSelect) {
        self.cellSelect(_imgView.image);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
