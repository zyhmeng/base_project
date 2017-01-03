//
//  YFNewsViewController.m
//  base_project
//
//  Created by zyh on 16/12/29.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFNewsViewController.h"
#import "YHTitleSlideScrollView.h"
#import "YFNewsTableViewPage.h"


@interface YFNewsViewController ()<UIScrollViewDelegate,YHTitleSlideClickedDelegate>
{
    //储存catName的数组
    NSMutableArray *_infoTypeTextArray;
    
    //储存数据列表的数组
    NSMutableArray *_infoBannerDataList;
    NSMutableArray *_infoDataList;
    
    //储存catId的数组
    NSMutableArray *_infoCatIdArray;//咨询catIdArray
    
}
@property (strong, nonatomic) UIScrollView *contentScrollView;

@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@property (nonatomic, strong) YHTitleSlideScrollView *titleSlideScrollView;

@property(nonatomic,strong)YFNewsTableViewPage *needScrollToTopPage;
@end

@implementation YFNewsViewController

- (UIScrollView *)contentScrollView
{
    if (!_contentScrollView) {
        
        _contentScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 40+64, UISCREENWIDTH, UISCREENHEIGHT-64-40)];
        
        [self.view addSubview:_contentScrollView];
    }
    
    return _contentScrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.navigationItem setTitle:@"仿网易新闻首页"];
    
    // 初始化容器scrollView
    [self initContentScrollView];
    
    [self initTitleSlideScrollView];
    
    [self initArray];
    
    // 请求健康质询type数据
    [self requestInfoTypeTitleData];
    
}

#pragma mark - 初始化上面滑动文字
- (void)initTitleSlideScrollView
{
    YHTitleSlideScrollView *titleSlideScrollView = [[YHTitleSlideScrollView alloc] init];
    
    titleSlideScrollView.delegate = self;
    
    titleSlideScrollView.selectTitleColor = APP_COLOR;
    
    titleSlideScrollView.frame = CGRectMake(0, 64, UISCREENWIDTH, 40);
    
    self.titleSlideScrollView = titleSlideScrollView;
    
    [self.view addSubview:titleSlideScrollView];
}

#pragma mark - 初始化需要的数组
- (void)initArray
{
    //储存catName的数组
    _infoTypeTextArray = [[NSMutableArray alloc]init];
    
    //储存数据列表的数组
    _infoBannerDataList = [[NSMutableArray alloc]init];
    _infoDataList = [[NSMutableArray alloc]init];
    
    //储存catId的数组
    _infoCatIdArray = [[NSMutableArray alloc]init];
    
}

#pragma mark - 请求类型数据
#pragma mark  请求健康质询type数据
- (void)requestInfoTypeTitleData
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setObject:@"8415" forKey:@"cmd"];
    
    [dict setObject:@"1" forKey:@"parentId"];
    
    DefWeakSelf(wself);
    [YFNetworking postWithUrl:nil refreshCache:YES params:dict success:^(id response) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        
        if ([Common IsRequestSuccess:response]) {
            
            NSArray *array = [Common GetRequestResultFromResponse:response];
            
            [_infoTypeTextArray addObject:@"推荐"];
            [_infoCatIdArray addObject:@"1"];
            
            for (NSDictionary *dict in array) {
                
                [_infoTypeTextArray addObject:[dict objectForKey:@"catName"]];
                [_infoCatIdArray addObject:[dict objectForKey:@"catId"]];
            }
            
            for (int i = 0; i < _infoCatIdArray.count; i++) {
                
                NSMutableArray *array = [NSMutableArray array];
                NSMutableArray *bannerArray = [[NSMutableArray alloc]init];
                
                [_infoDataList addObject:array];
                [_infoBannerDataList addObject:bannerArray];
            }
            
            wself.titleSlideScrollView.titleArray = _infoTypeTextArray;
            
            wself.contentScrollView.contentSize = CGSizeMake(UISCREENWIDTH*_infoCatIdArray.count, UISCREENHEIGHT-200);
            
            
            [wself initAddController];
            
            self.needScrollToTopPage = self.childViewControllers[0];
        }
        
    } fail:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
    }];
}

// 初始化子控制器
- (void)initAddController
{
    for (int i = 0; i < _infoTypeTextArray.count; i++) {
        
        YFNewsTableViewPage *tableViewPage = [[YFNewsTableViewPage alloc] init];
        
        tableViewPage.catId = _infoCatIdArray[i];
        
        [self addChildViewController:tableViewPage];
    }
    
    // 添加默认的控制器
    UIViewController *vc = [self.childViewControllers firstObject];
    
    vc.view.frame = self.contentScrollView.bounds;
    
    [self.contentScrollView addSubview:vc.view];

}

/** 滚动结束后调用（代码导致） */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 获得索引
    NSUInteger index = scrollView.contentOffset.x / self.contentScrollView.frame.size.width;
    
    // 滚动标题栏
    [self.titleSlideScrollView titleClickedWithIndex:index];
    
    // 添加控制器
    YFNewsTableViewPage *newsVc = self.childViewControllers[index];
    
    newsVc.catId = _infoCatIdArray[index];
    
    if (newsVc.view.superview) return;
    
    newsVc.view.frame = scrollView.bounds;
    
    [self.contentScrollView addSubview:newsVc.view];
    
    [self setScrollToTopWithTableViewIndex:index];
}

/** 滚动结束（手势导致） */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
}

- (void)initContentScrollView
{
    self.contentScrollView.delegate = self;
    self.contentScrollView.pagingEnabled = YES;
    self.contentScrollView.alwaysBounceVertical = NO;
    self.contentScrollView.alwaysBounceHorizontal = NO;
    self.contentScrollView.userInteractionEnabled = YES;
}

- (void)titleSlideClickedWithIndex:(NSInteger)index
{
    [self.contentScrollView setContentOffset:CGPointMake(UISCREENWIDTH*index, self.contentScrollView.contentOffset.y) animated:YES];

    [self setScrollToTopWithTableViewIndex:index];
}

#pragma mark - ScrollToTop
- (void)setScrollToTopWithTableViewIndex:(NSInteger)index
{
    self.needScrollToTopPage.tableView.scrollsToTop = NO;
    self.needScrollToTopPage = self.childViewControllers[index];
    self.needScrollToTopPage.tableView.scrollsToTop = YES;
}



@end
