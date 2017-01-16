//
//  YFQQDismissAnimation.m
//  base_project
//
//  Created by zyh on 17/1/13.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFQQDismissAnimation.h"
#import "YFMusicDetailViewController.h"
#import "YFQQPlayMusicAnimationViewController.h"

@implementation YFQQDismissAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    UINavigationController *nacVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    YFQQPlayMusicAnimationViewController *toVC;
    for (UIViewController *vc in nacVC.childViewControllers) {
        
        if ([vc isKindOfClass:[YFQQPlayMusicAnimationViewController class]]) {
            
            toVC = (YFQQPlayMusicAnimationViewController *)vc;
        }
    }

    YFMusicDetailViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    UIImage *image = [self imageFromView:fromVC.imageView];
    
    UIImageView *imageSnapshot = [[UIImageView alloc] initWithImage:image];
    
    imageSnapshot.frame = [transitionContext.containerView convertRect:fromVC.imageView.frame fromView:fromVC.view];
    fromVC.imageView.hidden = YES;
    toVC.imageView.hidden = YES;
    
    [transitionContext.containerView addSubview:imageSnapshot];
    [transitionContext.containerView addSubview:fromVC.view];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    [UIView animateWithDuration:duration animations:^{
       
        fromVC.view.alpha = 0;
        
        CGRect frame = [transitionContext.containerView convertRect:toVC.imageView.frame fromView:toVC.view];
        imageSnapshot.frame = frame;
        
    } completion:^(BOOL finished) {
        
        toVC.imageView.hidden = NO;
        fromVC.imageView.hidden = NO;
        [imageSnapshot removeFromSuperview];
        
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (UIImage *)imageFromView:(UIView *)snapView {
    
    UIGraphicsBeginImageContext(snapView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [snapView.layer renderInContext:context];
    UIImage *targetImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return targetImage;
}

@end
