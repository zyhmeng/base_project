//
//  YHTitleSlideScrollView.m
//  JianKangGuanLi
//
//  Created by zyh on 16/9/8.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YHTitleSlideScrollView.h"

@interface YHTitleSlideScrollView()

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UIView *indicationView;
@end

@implementation YHTitleSlideScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews
{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, 40)];
    
    self.scrollView = scrollView;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    [self addSubview:scrollView];
}

- (UIView *)indicationView
{
    if (!_indicationView) {
        
        _indicationView = [[UIView alloc]initWithFrame:CGRectMake(0, 38, UISCREENWIDTH*0.22, 2)];
    }
    
    return _indicationView;
}

- (void)setTitleArray:(NSArray *)titleArray
{
    _titleArray = titleArray;
    
    self.scrollView.contentSize = CGSizeMake(UISCREENWIDTH*0.22*titleArray.count, 40);
    
    CGFloat width = UISCREENWIDTH * 0.22;
    CGFloat height = 40;
    CGFloat y = 0;
    CGFloat x;
    
    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        
        [button setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(titleButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
         
        x = width * i;
        
        button.tag = i;
        
        button.frame = CGRectMake(x, y, width, height);
        
        if (i == 0) {
            
            [button setTitleColor:APP_COLOR forState:UIControlStateNormal];
        }
        
        self.indicationView.tag = i;
        
        [self.scrollView addSubview:self.indicationView];
        
        [self.scrollView addSubview:button];
        
    }
}

- (void)setSelectTitleColor:(UIColor *)selectTitleColor
{
    _selectTitleColor = selectTitleColor;
    
    self.indicationView.backgroundColor = selectTitleColor;
    
    for (UIView *view in self.scrollView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]])
        {
            
            UIButton *button = (UIButton *)view;
            
            if (button.tag == 0) {
                
                [button setTitleColor:self.selectTitleColor forState:UIControlStateNormal];
            }
            
        }
    }
}

- (void)titleButtonClick:(UIButton *)button
{
    if (![button.titleLabel.textColor isEqual:self.selectTitleColor]) {
        
        // 改变颜色
        [self changeButtonColorWithButton:button];
    }
    
    CGFloat offsetx = button.center.x - self.scrollView.frame.size.width * 0.5;
    
    CGFloat offsetMax = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
    
    if (offsetx < 0) {
        offsetx = 0;
    }else if (offsetx > offsetMax){
        offsetx = offsetMax;
    }
    
    CGPoint offset = CGPointMake(offsetx, self.scrollView.contentOffset.y);
    
    [self.scrollView setContentOffset:offset animated:YES];
    
}

- (void)changeButtonColorWithButton:(UIButton *)button
{
    for (UIView *view in self.scrollView.subviews) {
        
        [UIView animateWithDuration:0.25 animations:^{
           
            self.indicationView.frame = CGRectMake(button.tag * UISCREENWIDTH*0.22, 38, UISCREENWIDTH*0.22, 2);
        }];
        
            
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)view;
            
            if (button.tag == btn.tag) {
                
                [btn setTitleColor:self.selectTitleColor forState:UIControlStateNormal];
            }else
            {
                [btn setTitleColor:APP_BLACKCOLOR forState:UIControlStateNormal];
            }
            
        }
    }
    
    if ([self.delegate respondsToSelector:@selector(titleSlideClickedWithIndex:)]) {
        
        [self.delegate titleSlideClickedWithIndex:button.tag];
    }
}

- (void)titleClickedWithIndex:(int)index
{
    for (UIView *view in self.scrollView.subviews) {
        
        if ([view isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)view;
            
            if (btn.tag == index) {
                
                [self titleButtonClick:btn];
            }
        }
    }
}

@end
