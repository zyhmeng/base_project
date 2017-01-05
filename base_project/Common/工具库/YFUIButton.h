//
//  YFUIButton.h
//  YFButtonDemo
//
//  Created by zyh on 16/1/14.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFUIButton : UIButton


/**
 *  四角带弧度的button 可以设置弧度和边框的宽度，颜色
 *
 *  @param radius 四角的弧度半径
 *  @param color  边框颜色
 *  @param width  边框宽度
 */
- (void)setButtonCornerRadius:(CGFloat)radius borderColor:(UIColor *)color andBorderWidth:(CGFloat)width;

/**
 *  圆角的button 可以设置边框的宽度和颜色
 *
 *  @param color 边框颜色
 *  @param width 边框宽度
 */
- (void)setButtonRoundedRectBorderColor:( UIColor *)color andBorderWidth:(CGFloat)width;

@end
