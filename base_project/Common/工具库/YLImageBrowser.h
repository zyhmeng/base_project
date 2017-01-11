//
//  YLImageBrowser.h
//
//  Created by Yin on 15/6/1.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface YLImageBrowser : NSObject

+ (void)fullscreenImageView:(UIImageView *)imageView;//没有图片时不全屏
+ (void)fullscreenButton:(UIButton *)button;

@end
