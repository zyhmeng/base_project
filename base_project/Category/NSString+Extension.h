//
//  NSString+Extension.h
//  NStringExtension
//
//  Created by zyh on 16/8/19.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Extension)


/**
*  验证是否为手机号
*/
- (BOOL)CheckIsTelNum;


/**
 *  判断是否为正确的email
 */
- (BOOL)isValidateEmail;


/**
 *  判断字符串是否为空
 */
- (BOOL)stringIsEmpty;


/**
 *  给地一个最大的宽度，计算文字的显示的大小，适用于Label字典换行时
 */
- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth;
@end
