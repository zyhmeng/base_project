//
//  YHTitleSlideScrollView.h
//  JianKangGuanLi
//
//  Created by zyh on 16/9/8.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YHTitleSlideClickedDelegate <NSObject>

- (void)titleSlideClickedWithIndex:(NSInteger)index;

@end

@interface YHTitleSlideScrollView : UIView

@property (nonatomic, strong) NSArray *titleArray;
@property (nonatomic, strong) UIColor *selectTitleColor;

@property (nonatomic, weak)id<YHTitleSlideClickedDelegate>delegate;

- (void)titleClickedWithIndex:(int)index;
@end
