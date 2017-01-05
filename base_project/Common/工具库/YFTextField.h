//
//  YFTextField.h
//  YFTextField
//
//  Created by zyh on 15/12/16.
//  Copyright © 2015年 zyh. All rights reserved.
//

/*  CustomTextfield
 *
 *  提供了四种形式的textField，原生没有边框和圆角的，带下划线和自定义边框圆角的，可以通过枚举选择边框类型，可以设置边框的颜色和宽度
 *
 *  可以设置文字或者图片，显示在textField左边
 *
 *  可以设置placeholder的字体的大小和颜色
 */

typedef enum {
    
    YFTextFieldBorderStyleNone,
    YFTextFieldBorderStyleUnderLine,
    YFTextFieldBorderStyleCustomRoundedRect,
    YFTextFieldBorderStyleSystemRoundedRect
    
}YFTextFieldBorderStyle;

typedef enum {
    
    YFTextAlignmentRight,
    YFTextAlignmentLeft,
    
}YFTextAlignmentType;

#import <UIKit/UIKit.h>


@interface YFTextField : UITextField


/**
 *  enum select TextField Border style
 *
 *  @param style textField border style
 */
- (void)setYFTextFieldBorderStyle:(YFTextFieldBorderStyle)style;
/**
 *  textField  imagrLeftView
 *
 *  @param leftImage leftView image
 *  @param spacing   leftView and input spacing
 *  @param imageWH   image width and height
 */
- (void)setYFTextFieldWithLeftViewImage:(UIImage *)leftImage spacing:(CGFloat)spacing imageWH:(CGSize)imageWH;

/**
 *  textField textLeftView
 *
 *  @param leftViewText leftView text
 *  @param spacing      leftView and input spacing
 *  @param textFont     leftViewTextFont
 *  @param textColor    leftViewTextColor
 */
- (void)setYFTextFieldWithLeftViewText:(NSString *)leftViewText spacing:(CGFloat)spacing textFont:(UIFont *)textFont andTextColor:(UIColor *)textColor;

/**
 *  textField border lineColor and lineWidth
 *
 *  @param color line color
 *  @param width line width
 */
- (void)setYFTextFieldWithBorderLineColor:(UIColor *)color andWidth:(CGFloat)width;
/**
 *  textField border corner radius
 *
 *  @param radius corner radius
 */
- (void)setYFTextFieldWithBorderCornerRadius:(CGFloat)radius;

/**
 *  textField placeholder text
 *
 *  @param placeholderText placeholder text
 *  @param font            text font
 *  @param color           text color
 */
//- (void)setYFTextFieldWithPlaceholderText:(NSString *)placeholderText textFont:(UIFont *)font andTextColor:(UIColor *)color;

//placeholder right alignment
- (void)setYFTextFieldWithPlaceholderText:(NSString *)placeholderText alignment:(YFTextAlignmentType)type textFont:(UIFont *)font andTextColor:(UIColor *)color;

@end
