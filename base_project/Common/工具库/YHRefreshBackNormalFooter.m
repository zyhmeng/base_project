//
//  YHRefreshBackNormalFooter.m
//  JianKangGuanLi
//
//  Created by zyh on 16/9/27.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YHRefreshBackNormalFooter.h"

@implementation YHRefreshBackNormalFooter

- (void)prepare
{
    [super prepare];
    
    self.automaticallyChangeAlpha = YES;

    [self setTitle:@"上拉可以加载更多" forState:MJRefreshStateIdle];
    
    [self setTitle:@"松开立即加载更多" forState:MJRefreshStatePulling];
    
    [self setTitle:@"正在加载更多的数据..." forState:MJRefreshStateRefreshing];
    
    [self setTitle:@"已经全部加载完毕" forState:MJRefreshStateNoMoreData];
    
}


@end
