//
//  PresentingAnimation.m
//  base_project
//
//  Created by zyh on 17/1/12.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFPresentingAnimation.h"
#import "UIColor+CustomColors.h"

@implementation YFPresentingAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    fromView.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
    fromView.userInteractionEnabled = NO;
    
    UIView *dimmingView = [[UIView alloc] initWithFrame:fromView.bounds];
    dimmingView.backgroundColor = [UIColor customGrayColor];
    dimmingView.layer.opacity = 0.0;
    
    
}

@end
