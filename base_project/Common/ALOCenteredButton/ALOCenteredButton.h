
/**
 *  处理UIButton的Image跟Title位置的UIButton子工具类
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

/**
 *  处理UIButton的Image跟Title位置的UIButton子工具类
 *
 *  @param buttonOrientation      图片与标题位置枚举 未设置则默认为ALOCenteredButtonOrientationVertical
 *  @param imageLabelSpacing      图片与标题间距 未设置则默认10.0f
 *  @param laberColor             标题颜色 注意 从xib或者代码来实例化的对象 若需要自定义颜色 都需要通过该属性来设置颜色 未设置则默认为黑色
 */

@interface ALOCenteredButton : UIButton
@property (nonatomic, assign) ALOCenteredButtonOrientation buttonOrientation;
@property (nonatomic, assign) CGFloat imageLabelSpacing;
@property (nonatomic, strong) UIColor *laberColor;
@end
