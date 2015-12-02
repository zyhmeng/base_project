//
//  POPTool.h
//  
//
//  Created by 123 on 15/10/28.
//  Copyright (c) 2015年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    EnumFadeStateFadeOut, //淡入
    EnumFadeStateFadeIn  //淡出

}EnumFadeState;

typedef enum{
    EnumMoveTypeMoveToValueX,    //沿着X轴移动
    EnumMoveTypeMoveToValueY,    //沿着Y轴移动
    EnumMoveTypeMoveToValuePoint //移动到点
    
}EnumMoveType;


@interface POPTool : NSObject


/**
 *  UIView的淡出和淡入
 *
 * @param view  指定淡出和淡入的UIView
 * 
 * @param type  枚举定义UIView的淡入和淡出
 */

+(void)fadeImageView:(UIView *)view ByFadeType:(EnumFadeState)type;

/**
 *  UIView的旋转
 *
 * @param view   指定要旋转的UIView
 *
 * @param degree 指定要旋转的度数
 */
+(void)rotateWithView:(UIView *)view andRotateDegree:(CGFloat)degree;



/**
 *  UIView的缩放
 *
 * @param   view         指定要缩放的UIView
 *
 * @param zoomingInSize  指定要放大到的尺寸
 * 
 * @param zoomingOutSize 指定要缩小到的尺寸
 *
 * @param bounciness     弹性值
 *
 * @param speed          弹性速度
 */

+(void)zoomingWithUIView:(UIView *)view zoomingInSize:(CGSize)zoomingInSize zoomingOutSize:(CGSize)zoomingOutSize bounciness:(CGFloat)bounciness speed:(CGFloat)speed;


/**
 *  UIView的移动
 *
 * @param view   指定要旋转的UIView
 *
 * @param type   枚举移动的类型
 *
 * @param valueX 指定要移动到X轴的位置(如果想只在X轴移动，Y值传入0)
 *
 * @param valueY 指定要移动到Y轴的位置(如果想只在Y轴移动，X值传入0)
 *
 */
+(void)moveWithUIView:(UIView *)view ByMoveType:(EnumMoveType)type toValueX:(CGFloat)valueX toValueY:(CGFloat)valueY;

/**
 *  UIView的弹出
 *
 * @param   view         指定要弹出的UIView
 *
 * @param showRect       弹出的位置
 *
 * @param showBounciness 弹性值
 *
 * @param showSpeed      弹性速度
 *
 */
+(void)showWithUIView:(UIView *)view showViewRect:(CGRect)showRect SpringBounciness:(CGFloat)showBounciness SpringSpeed:(CGFloat)showSpeed;




@end
