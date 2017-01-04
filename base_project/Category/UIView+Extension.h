//
//  UIView+Extension.h
//  百思不得姐
//
//  Created by zyh on 16/6/29.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat yh_width;

@property (nonatomic, assign) CGFloat yh_height;

@property (nonatomic, assign) CGFloat yh_x;

@property (nonatomic, assign) CGFloat yh_y;

@property (nonatomic, assign) CGFloat yh_centerX;

@property (nonatomic, assign) CGFloat yh_centerY;

@property (nonatomic, assign) CGFloat yh_right;

@property (nonatomic, assign) CGFloat yh_bottom;

+ (instancetype)viewFromXib;
@end
