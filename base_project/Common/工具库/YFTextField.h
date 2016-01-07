//
//  YFTextField.h
//  YFTextField
//
//  Created by zyh on 15/12/16.
//  Copyright © 2015年 zyh. All rights reserved.
//

/*  CustomTextfield
 *
 *  可以满足Textfield下面带下划线，和leftView为文字或者图片的情况
 *
 *  只需要调用setup的三个方法，设置需要的图片，文字和下划线即可
 *
 *  Textfield的其他用到的属性都设置了默认值，如需要特殊更改可自行重写该属性的set方法
 */
#import <UIKit/UIKit.h>


@interface YFTextField : UITextField

//DefaulColor lightGrayColor
@property (nonatomic, strong) UIColor *leftTextFontColor;
@property (nonatomic, strong) UIColor *inputTextFontColor;
@property (nonatomic, strong) UIColor *fineLineColor;

//DefaulttextFieldLeftViewImageWH 21
@property (nonatomic, assign) CGFloat textFieldLeftViewImageWH;

//DefaultLeftTextFont   14
@property (nonatomic)  int  leftTextFont;

//DefaultTextFieldHight 30
@property (nonatomic)  int  textFieldHight;


/**
 * TextField  leftViewWithImage
 *
 * @param leftImage  leftView的放入的图片
 *
 * @param spacing    leftView和textfield输入框的距离
 *
 * @param fineLine   BOOL值决定是否需要下划线
 */
- (void)setupTextFieldWithLeftViewImage:(UIImage *)leftImage textViewLeftViewSpacing:(CGFloat)spacing andFineLine:(BOOL)fineLine;


/**
 * TextField  leftViewWithText
 *
 * @param leftViewText  leftView的放入的文字
 *
 * @param spacing       leftView和textfield输入框的距离
 *
 * @param fineLine      BOOL值决定是否需要下划线
 */
- (void)setupTextFieldWithLeftViewText:(NSString *)leftViewText textViewLeftViewSpacing:(CGFloat)spacing andFineLine:(BOOL)fineLine;


/**
 * TextField  no leftView
 *
 * @param fineLine      BOOL值决定是否需要下划线
 */
- (void)setupTextFieldWithFineLine:(BOOL)fineLine;

@end
