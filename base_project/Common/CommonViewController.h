//
//  CommonViewController.h
//  wuse
//
//  Created by jangbuk on 15/8/21.
//  Copyright (c) 2015年 jangbuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommonViewController : UIViewController
@property(readwrite,assign) int n_page_no;

@property (nonatomic,strong) UIButton *navBackBT;//返回按钮
@property (nonatomic,strong) UIButton *navRightBT;//右侧按钮

@end
