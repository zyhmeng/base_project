//
//  YFTransitionViewController.m
//  base_project
//
//  Created by zyh on 17/1/12.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFTransitionViewController.h"
#import "YFModalViewController.h"
#import "YFPresentingAnimation.h"
#import "YFDismissingAnimation.h"

@interface YFTransitionViewController ()<UIViewControllerTransitioningDelegate>

@end

@implementation YFTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addButton];
}

- (void)addButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    
    button.yh_width = UISCREENWIDTH;
    button.yh_height = 40;
    button.center = self.view.center;
    
    button.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [button setTitle:@"Present Modal View Controller" forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
}

- (void)buttonClicked
{
    YFModalViewController *modalVC = [[YFModalViewController alloc] init];
    
//    modalVC.transitioningDelegate = self;
//    modalVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:modalVC animated:YES completion:nil];
}

#pragma mark -UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [YFPresentingAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [YFDismissingAnimation new];
}

@end
