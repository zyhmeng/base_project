//
//  YFUIButton.m
//  YFButtonDemo
//
//  Created by zyh on 16/1/14.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import "YFUIButton.h"

@interface YFUIButton ()

@property (nonatomic) CGFloat btnHeight;
@end

@implementation YFUIButton

#pragma mark - 四角带弧度的button
- (void)setButtonCornerRadius:(CGFloat)radius borderColor:(UIColor *)color andBorderWidth:(CGFloat)width
{
    //加上masksToBounds才会切割角
    self.layer.masksToBounds = YES;
    [self.layer setCornerRadius:radius];
    [self.layer setBorderWidth:width];
    [self.layer setBorderColor:color.CGColor];
}

#pragma mark - 圆角的button
- (void)setButtonRoundedRectBorderColor:(UIColor *)color andBorderWidth:(CGFloat)width
{
    //加上masksToBounds才会切割角
    self.layer.masksToBounds = YES;
    [self.layer setCornerRadius:self.frame.size.height*0.5];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}


@end
