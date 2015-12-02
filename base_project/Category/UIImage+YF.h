
/**
 *  扩展UIImage类 常用图像处理方法
 */


#import <UIKit/UIKit.h>

@interface UIImage (YF)

/**
 *  截取Image
 *
 *  @param rect 按照位置截取
 *
 *  @return 返回截取后的Image
 */

- (UIImage*)getSubImage:(CGRect)rect;

/**
 *  等比缩放Image
 *
 *  @param size 指定等比缩放大小
 *
 *  @return 返回缩放后的Image
 */

- (UIImage*)scaleToSize:(CGSize)size;
@end
