//
//  YFQQPresentAnimation.m
//  base_project
//
//  Created by zyh on 17/1/13.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFQQPresentAnimation.h"
#import "YFQQPlayMusicAnimationViewController.h"
#import "YFMusicDetailViewController.h"

@implementation YFQQPresentAnimation

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext
{
    return 0.25;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    // 获得 from to 控制器
    UINavigationController *nacVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];

    YFQQPlayMusicAnimationViewController *fromVC;
    for (UIViewController *vc in nacVC.childViewControllers) {
        
        if ([vc isKindOfClass:[YFQQPlayMusicAnimationViewController class]]) {
            
            fromVC = (YFQQPlayMusicAnimationViewController *)vc;
        }
    }
    
    YFMusicDetailViewController *toVC =  [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    // 获取动画时长
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    
    // 截取到fromVC上的imageView
    UIImage *image = [self imageFromView:fromVC.imageView];
    UIImageView *imageSnapshot = [[UIImageView alloc] initWithImage:image];
    
    // 计算出imageView 在 containerView 的位置
    imageSnapshot.frame = [transitionContext.containerView convertRect:fromVC.imageView.frame fromView:fromVC.view];
    fromVC.imageView.hidden = YES;
    
    toVC.view.frame = [transitionContext finalFrameForViewController:toVC];
    toVC.view.alpha = 0;
    toVC.imageView.hidden = YES;
    
    [transitionContext.containerView addSubview:imageSnapshot];
    [transitionContext.containerView addSubview:toVC.view];
    
    [UIView animateWithDuration:duration animations:^{
       
        toVC.view.alpha = 1.0;
        
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
