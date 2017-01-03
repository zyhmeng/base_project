//
//  YFTitleLabel.m
//  base_project
//
//  Created by zyh on 17/1/3.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFTitleLabel.h"

@implementation YFTitleLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:18];
        
        self.scale = 0.0;
    }
    return self;
}

- (void)setScale:(CGFloat)scale
{
    _scale = scale;
    
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1];
    
    CGFloat minScale = 0.7;
    CGFloat trueScale = minScale + (1- minScale) * scale;
    
    self.transform = CGAffineTransformMakeScale(trueScale, trueScale);
}

@end
