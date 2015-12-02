//
//  POPTool.m
//
//
//  Created by 123 on 15/10/28.
//  Copyright (c) 2015年 jangbuk. All rights reserved.
//

#import "POPTool.h"

@implementation POPTool

//根据类型判断UIView的淡出和淡入
+(void)fadeImageView:(UIView *)view ByFadeType:(EnumFadeState)type
{
    switch (type) {
        case EnumFadeStateFadeIn:{
            
            POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
            basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            if (view.alpha == 1.0) {
                return;
            }
            basic.fromValue = @(0.0);
            basic.toValue = @(1.0);
            [view pop_addAnimation:basic forKey:@"fade"];
            }
            break;
        case EnumFadeStateFadeOut:{
            
            POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPViewAlpha];
            basic.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
            if (view.alpha == 0.0) {
                return;
            }
            
            
            basic.fromValue = @(1.0);
            basic.toValue = @(0.0);
            [view pop_addAnimation:basic forKey:@"fade"];
            }
        default:
            break;
    }
}


//旋转UIView
+(void)rotateWithView:(UIView *)view andRotateDegree:(CGFloat)degree
{
    POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerRotation];
    basic.toValue = @(degree);
    
    [view.layer pop_addAnimation:basic forKey:@"rotation"];
}

//弹出UIView
+(void)showWithUIView:(UIView *)view showViewRect:(CGRect)showRect SpringBounciness:(CGFloat)showBounciness SpringSpeed:(CGFloat)showSpeed 
{
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
    
    spring.toValue = [NSValue valueWithCGRect:showRect];
    spring.springBounciness = showBounciness;
    
    spring.springSpeed = showSpeed;
    [view pop_addAnimation:spring forKey:@"menuAnimation"];
    
}

//缩放
+(void)zoomingWithUIView:(UIView *)view zoomingInSize:(CGSize)zoomingInSize zoomingOutSize:(CGSize)zoomingOutSize bounciness:(CGFloat)bounciness speed:(CGFloat)speed
{
    POPSpringAnimation *springAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerSize];
    
    CGRect rect = view.frame;
    
    if (rect.size.width == zoomingOutSize.width||rect.size.height == zoomingOutSize.height) {
        springAnimation.toValue = [NSValue valueWithCGSize:zoomingInSize];
    }else
    {
        springAnimation.toValue = [NSValue valueWithCGSize:zoomingOutSize];
    }
    
    //弹性值
    springAnimation.springBounciness = bounciness;
    
    //弹性速度
    springAnimation.springSpeed = speed;
    
    [view.layer pop_addAnimation:springAnimation forKey:@"changSize"];
    
}

//UIView的移动
+(void)moveWithUIView:(UIView *)view ByMoveType:(EnumMoveType)type toValueX:(CGFloat)valueX toValueY:(CGFloat)valueY
{
    switch (type) {
        case EnumMoveTypeMoveToValueX:{
            POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionX];
            basic.toValue = @(valueX);
            [view.layer pop_addAnimation:basic forKey:@"position"];
            
        }
            
        break;
        case EnumMoveTypeMoveToValueY:{
            POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPositionY];
            basic.toValue = @(valueY);
            [view.layer pop_addAnimation:basic forKey:@"position"];
            }
        break;
        case EnumMoveTypeMoveToValuePoint:{
            POPBasicAnimation *basic = [POPBasicAnimation animationWithPropertyNamed:kPOPLayerPosition];
            basic.toValue = [NSValue valueWithCGPoint:CGPointMake(valueX, valueY)];
            [view.layer pop_addAnimation:basic forKey:@"position"];
        }
    }
}

@end


