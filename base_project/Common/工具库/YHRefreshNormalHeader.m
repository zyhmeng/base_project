//
//  YHRefreshNormalHeader.m
//  JianKangGuanLi
//
//  Created by zyh on 16/9/26.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YHRefreshNormalHeader.h"

@implementation YHRefreshNormalHeader

- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    
    [self setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    [self setTitle:@"松开立刻刷新" forState:MJRefreshStatePulling];
    [self setTitle:@"正在刷新数据中..." forState:MJRefreshStateRefreshing];
    
    self.lastUpdatedTimeLabel.hidden = YES;
}

@end
