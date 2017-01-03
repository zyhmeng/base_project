//
//  HistoryItem.m
//  HistoryDemo
//
//  Created by 润泰－技术部 on 16/4/2.
//  Copyright © 2016年 ruitaiLong. All rights reserved.
//

#import "HistoryItem.h"



@implementation HistoryItem

- (id)initWithString:(NSString *)str WithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if(self){
        
        UILabel * strLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, frame.size.width-5, 30)];
        strLabel.textAlignment = NSTextAlignmentCenter;
        strLabel.font = [UIFont systemFontOfSize:15];
        strLabel.textColor = [UIColor blackColor];
        strLabel.text = str;
        strLabel.layer.cornerRadius = 5.0;
        strLabel.layer.masksToBounds = YES;
        strLabel.backgroundColor = RGBA(242, 242, 242, 1);
        
        [self addSubview:strLabel];
       
    }
    return self;
}

- (void)addtapGesWithtarget:(id)target action:(SEL)select {
    
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:select];
    [self addGestureRecognizer:tap];
}


@end
