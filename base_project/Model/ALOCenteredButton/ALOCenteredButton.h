
/**
 *  处理Button的Image跟Title位置的工具类
 */

#import <UIKit/UIKit.h>

/**
 *  Button的Image跟Title位置枚举定义
 */
typedef NS_ENUM(NSUInteger, ALOCenteredButtonOrientation) {
    /**
     *  Image在左 Title在右
     */
    ALOCenteredButtonOrientationLeftToRight,
    /**
     *  Image在右 Title在左
     */
    ALOCenteredButtonOrientationRightToLeft,
    /**
     *  Image在上 Title在下
     */
    ALOCenteredButtonOrientationVertical,
};

@interface ALOCenteredButton : UIButton
@property (nonatomic, assign) ALOCenteredButtonOrientation buttonOrientation;//图片文字位置枚举
@property (nonatomic, assign) CGFloat imageLabelSpacing;//图片文字间距
@property (nonatomic, strong) UIColor *laberColor;//标题颜色

@end
