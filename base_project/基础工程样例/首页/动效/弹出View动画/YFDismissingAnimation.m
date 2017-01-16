//
//  YFDismissingAnimation.m
//  base_project
//
//  Created by zyh on 17/1/12.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFDismissingAnimation.h"

@implementation YFDismissingAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.5;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view;
    toView.tintAdjustmentMode = UIViewTintAdjustmentModeNormal;
    toView.userInteractionEnabled = YES;
    
    UIView *fromView = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey].view;
    
    __block UIView *dimmingView;
    [transitionContext.containerView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (obj.layer.opacity < 1.f) {
            
            dimmingView = obj;
            *stop = YES;
        }
    }];
    
    POPBasicAnimation *opacityAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerOpacity];
    opacityAnimation.toValue = @(0.0);
    
    POPBasicAnimation *offScreenAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    
    offScreenAnimation.toValue = @(-fromView.layer.position.y);
    
    [offScreenAnimation setCompletionBlock:^(POPAnimation *animation, BOOL finished) {
       
        [transitionContext completeTransition:YES];
    }];
    
    [dimmingView.layer pop_addAnimation:opacityAnimation forKey:@"opacityAnimation"];
    [fromView.layer pop_addAnimation:offScreenAnimation forKey:@"offScreenAnimation"];
}

@end
