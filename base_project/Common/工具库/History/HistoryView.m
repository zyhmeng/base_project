//
//  HistoryView.m
//  HistoryDemo
//
//  Created by 润泰－技术部 on 16/4/2.
//  Copyright © 2016年 ruitaiLong. All rights reserved.
//

#import "HistoryView.h"
#import "HistoryItem.h"

@implementation HistoryView

{
    UIScrollView * strScrollView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if(self){
        
        [self customScrollViewWithFrame:frame];
        self.historyDataArray = [[NSMutableArray alloc]init];
        
    }
    return self;
}
- (void)customScrollViewWithFrame:(CGRect)frame {
    
    strScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    strScrollView.backgroundColor = [UIColor whiteColor];
    strScrollView.bounces = NO;
    strScrollView.delegate = self;
    strScrollView.showsVerticalScrollIndicator = FALSE;
    strScrollView.showsHorizontalScrollIndicator = FALSE;
    [self addSubview:strScrollView];
}

- (void)reloadData {
    //清空所有按钮
    for (UIView * view in strScrollView.subviews) {
        
        [view removeFromSuperview];
    }
    int j = 0;
    CGFloat viewX = 0;
    CGFloat viewY = 0;
    for (int i=0; i<self.historyDataArray.count; i++) {
        CGSize size = [self sizeForStringWithFont:[UIFont systemFontOfSize:16] WithString:self.historyDataArray[i]];
        CGFloat k = viewX + 5+size.width+35+5;
        if(k>[UIScreen mainScreen].bounds.size.width){
            viewX = 0;
            j++;
        }
        viewY = j*(5+30);
        HistoryItem * item = [[HistoryItem alloc]initWithString:self.historyDataArray[i] WithFrame:CGRectMake(5+viewX, viewY, size.width+20+5, 20)];
        item.tag = i;
        item.cancelButton.tag = i;
        [item.cancelButton addTarget:self action:@selector(onClickItemCancel:) forControlEvents:UIControlEventTouchUpInside];
        [item addtapGesWithtarget:self action:@selector(selectItemTag:)];
        [strScrollView addSubview:item];
        viewX = 5+item.bounds.size.width + viewX;
        
    }
    [strScrollView setContentSize:CGSizeMake(0, (j+1)*(5+20))];
    
}
- (void)onClickItemCancel:(UIButton *)button {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(onClickCancelWithTag:)]){
        [self.delegate onClickCancelWithTag:button.tag];
    }
    [self.historyDataArray removeObjectAtIndex:button.tag];
    [self reloadData];
}
- (void)selectItemTag:(UITapGestureRecognizer *)tap {
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(selectItemWithTag:)]){
        [self.delegate selectItemWithTag:tap.view.tag];
    }
}
- (CGSize)sizeForStringWithFont:(UIFont*)font WithString:(NSString *)str
{
    CGSize size = CGSizeMake(0, 0);
    if (str == nil || [str length] < 1)
    {
        return size;
    }
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
    {
        size = [str sizeWithAttributes:@{ NSFontAttributeName:font}];
    }
    else
    {
        size = [str sizeWithFont:font];
    }
    return size;
    
}

@end
