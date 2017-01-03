//
//  YFHotSearchViewController.m
//  base_project
//
//  Created by zyh on 16/12/23.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFHotSearchViewController.h"
#import "HistoryView.h"

@interface YFHotSearchViewController ()<HistoryViewDelegate>

{
    HistoryView *_hotBtnView;
}

@end

@implementation YFHotSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"热门搜索文字排序"];
    
    [self setupHistoryView];
    
    [_hotBtnView.historyDataArray addObjectsFromArray:@[@"热门搜索",@"文字排序",@"啦啦啦",@"陈建安都得是多少",@"大沙发斯蒂芬",@"士大夫撒发放的",@"第三方为",@"爱而无法我万",@"大法师份额"]];
    
    [_hotBtnView reloadData];
    
}

- (void)setupHistoryView
{
    _hotBtnView = [[HistoryView alloc]initWithFrame:CGRectMake(0, 20, UISCREENWIDTH, 400)];
    
    [self.view addSubview:_hotBtnView];
}

@end
