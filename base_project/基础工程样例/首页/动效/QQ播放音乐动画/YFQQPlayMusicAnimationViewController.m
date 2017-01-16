//
//  YFQQPlayMusicAnimationViewController.m
//  base_project
//
//  Created by zyh on 17/1/13.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFQQPlayMusicAnimationViewController.h"
#import "YFMusicDetailViewController.h"
#import "YFQQPresentAnimation.h"
#import "YFQQDismissAnimation.h"

@interface YFQQPlayMusicAnimationViewController ()<UIViewControllerTransitioningDelegate>


@end

@implementation YFQQPlayMusicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"QQ播放音乐动画"];

    self.imageView.layer.cornerRadius = 30.0;
    self.imageView.layer.masksToBounds = YES;
}

- (IBAction)animationBegin:(id)sender {
    
    YFMusicDetailViewController *detailVC = [[YFMusicDetailViewController alloc] init];
    
    detailVC.transitioningDelegate = self;
    detailVC.modalPresentationStyle = UIModalPresentationCustom;
    
    [self presentViewController:detailVC animated:YES completion:nil];
}

#pragma mark - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [YFQQPresentAnimation new];
}

- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [YFQQDismissAnimation new];
}

@end
