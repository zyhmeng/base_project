//
//  UIView+Extension.m
//  百思不得姐
//
//  Created by zyh on 16/6/29.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView (Extension)

- (CGFloat)yh_width
{
    return self.frame.size.width;
}

- (void)setYh_width:(CGFloat)yh_width
{
    CGRect frame = self.frame;
    frame.size.width = yh_width;
    self.frame = frame;
}

- (CGFloat)yh_height
{
    return self.frame.size.height;
}

- (void)setYh_height:(CGFloat)yh_height
{
    CGRect frame = self.frame;
    frame.size.height = yh_height;
    self.frame = frame;
}

- (CGFloat)yh_x
{
    return self.frame.origin.x;
}

- (void)setYh_x:(CGFloat)yh_x
{
    CGRect frame = self.frame;
    frame.origin.x = yh_x;
    self.frame = frame;
}

- (CGFloat)yh_y
{
    return self.frame.origin.y;
}

- (void)setYh_y:(CGFloat)yh_y
{
    CGRect frame = self.frame;
    frame.origin.y = yh_y;
    self.frame = frame;
}

- (CGFloat)yh_centerX
{
    return self.center.x;
}

- (void)setYh_centerX:(CGFloat)yh_centerX
{
    CGPoint center = self.center;
    center.x = yh_centerX;
    self.center = center;
}

- (CGFloat)yh_centerY
{
    return self.center.y;
}

- (void)setYh_centerY:(CGFloat)yh_centerY
{
    CGPoint center = self.center;
    center.y = yh_centerY;
    self.center = center;
}

- (CGFloat)yh_right
{
    return CGRectGetMaxX(self.frame);
}

- (void)setYh_right:(CGFloat)yh_right
{
    self.yh_x = yh_right - self.yh_width;
}

- (CGFloat)yh_bottom
{
    return CGRectGetMaxY(self.frame);
}

- (void)setYh_bottom:(CGFloat)yh_bottom
{
    self.yh_y = yh_bottom - self.yh_height;
}

+ (instancetype)viewFromXib
{
    return [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
}

@end
