//
//  YFModalViewController.m
//  base_project
//
//  Created by zyh on 17/1/12.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFModalViewController.h"
#import "UIColor+CustomColors.h"
#import "Masonry.h"

@interface YFModalViewController ()

@end

@implementation YFModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.layer.cornerRadius = 8.0;
    self.view.backgroundColor = [UIColor customBlueColor];
    
    [self addDismissButton];
}

- (void)addDismissButton
{
    UIButton *dismissButton = [UIButton buttonWithType:UIButtonTypeSystem];
    dismissButton.translatesAutoresizingMaskIntoConstraints = NO;
    dismissButton.tintColor = [UIColor whiteColor];
    dismissButton.titleLabel.font = [UIFont fontWithName:@"Avenir" size:20];
    [dismissButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [dismissButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:dismissButton];
    
    [dismissButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.size.mas_equalTo(CGSizeMake(self.view.yh_width, 40));
        make.centerX.equalTo(self.view);
        
    }];
    
}

- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
