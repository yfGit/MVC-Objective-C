//
//  CellSelectController.m
//  MVC
//
//  Created by Wolf on 16/3/10.
//  Copyright © 2016年 许毓方. All rights reserved.
//

#import "CellSelectController.h"

@interface CellSelectController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLable;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;

@end

@implementation CellSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"CellSelected";
    
    _nameLable.text = self.name;
    _ageLabel.text  = self.age;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

@end
