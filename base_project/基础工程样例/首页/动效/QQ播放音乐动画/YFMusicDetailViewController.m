//
//  YFMusicDetailViewController.m
//  base_project
//
//  Created by zyh on 17/1/13.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFMusicDetailViewController.h"

@interface YFMusicDetailViewController ()

@end

@implementation YFMusicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.layer.cornerRadius = 100;
    self.imageView.layer.masksToBounds = YES;
}

- (IBAction)dismissClicked:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
