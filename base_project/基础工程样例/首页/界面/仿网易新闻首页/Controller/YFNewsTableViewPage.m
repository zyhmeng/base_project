//
//  YFNewsTableViewPage.m
//  base_project
//
//  Created by zyh on 16/12/29.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFNewsTableViewPage.h"
#import "YFNewsTableViewCell.h"
#import "SDCycleScrollView.h"
#import "SQLiteManager.h"

@interface YFNewsTableViewPage ()

@property (nonatomic, strong) NSMutableArray *bannerArray;
@property (nonatomic, strong) NSMutableArray <YFNewsModel *>*dataList;
@property (nonatomic, assign) int pageNo;

@property (nonatomic, strong) SDCycleScrollView *bannerView;

@end

@implementation YFNewsTableViewPage

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.backgroundColor = [UIColor clearColor];
    
    self.dataList = [NSMutableArray array];
    self.bannerArray = [NSMutableArray array];
    
    [self setupRefresh];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YFNewsTableViewCell class]) bundle:nil] forCellReuseIdentifier:@"YFNewsTableViewCell"];
    
    [YFNewsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        return @{
                 
                 @"desc" : @"description",
                 
                 };
    }];
    
    [self setupBanner];
    
    // 创建数据库表
    [[SQLiteManager shareIntance] createTable:newsListTable];
    
    // 监听网络状态
    [self networkingStatus];
  
}

- (void)networkingStatus
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        if (status == AFNetworkReachabilityStatusNotReachable) {
            
            NSArray *array = [[SQLiteManager shareIntance] quertyNewsListWithCatId:self.catId];
            
            // 处理数据
            [self handleDataWithModelList:array];
            
            [self shuaxinBanner];
            [self.tableView reloadData];
        }else
        {
            // 先清空数据库
            [[SQLiteManager shareIntance]eraseNewsTableWithCatId:self.catId];
            
            // 请求健康质询type数据
            [self requestDataList];
        }
    }];
    
    [manager startMonitoring];
}

// 处理数据
- (void)handleDataWithModelList:(NSArray *)array
{
    [_bannerArray removeAllObjects];
    [_dataList removeAllObjects];
    
    if ([self.catId isEqualToString:@"1"]) {
        
        for (YFNewsModel *model in array) {
            
            if ([model.isTop isEqualToString:@"Y"]) {
                
                [_bannerArray addObject:model];
            }else
            {
                [_dataList addObject:model];
            }
        }
    }else
    {
        if (array.count >= 3) {
            
            _bannerArray = [[array subarrayWithRange:NSMakeRange(0, 3)] mutableCopy];
            
            _dataList = [[array subarrayWithRange:NSMakeRange(3, array.count-3)] mutableCopy];
            
        }else
        {
           _bannerArray = [[array subarrayWithRange:NSMakeRange(0, array.count)] mutableCopy];
        }
    }
}


- (void)setupBanner
{
    SDCycleScrollView *bannerScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT*0.3) imagesGroup:nil];
    
    bannerScrollView.pageControlDotSize = CGSizeMake(5, 5);
    bannerScrollView.dotColor = [UIColor whiteColor];
    bannerScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    bannerScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;

    bannerScrollView.titleLabelBackgroundColor = RGBA(0, 0, 0, 0.5);
    bannerScrollView.titleLabelHeight = 30;
    bannerScrollView.titleLabelTextColor = [UIColor whiteColor];
    bannerScrollView.titleLabelTextFont = [UIFont systemFontOfSize:15];
    bannerScrollView.userInteractionEnabled = YES;
    
    bannerScrollView.placeholderImage = [UIImage imageNamed:@"home_banner_nobg"];
    
    self.bannerView = bannerScrollView;
    
    self.tableView.tableHeaderView = bannerScrollView;
    self.tableView.tableFooterView = [UIView new];
}

- (void)setupRefresh
{
    self.tableView.mj_header = [YHRefreshNormalHeader headerWithRefreshingBlock:^{
       
        self.pageNo = 0;
        [self requestDataList];
    }];
    
    self.tableView.mj_footer = [YHRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        self.pageNo++;
        [self requestDataList];
    }];
}

#pragma mark - 请求网络
- (void)requestDataList
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"8519" forKey:@"cmd"];
    
    [dict setObject:self.catId forKey:@"catId"];
    
    [dict setObject:[NSString stringWithFormat:@"%d",self.pageNo] forKey:@"pageNo"];
    [dict setObject:@"15" forKey:@"pageSize"];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [YFNetworking postWithUrl:nil refreshCache:YES params:dict success:^(id response) {
        
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        if ([Common IsRequestSuccess:response]) {
            
            NSMutableArray *array = [Common GetRequestResultFromResponse:response];
            
            if (self.pageNo == 0) {
                
                [self.bannerArray removeAllObjects];
                [self.dataList removeAllObjects];
                
                // 处理banner和cell的数据
                [self handleBannerAndCellData:array];
            }else
            {
                for (NSDictionary *dict in array) {
                    
                    YFNewsModel *model = [YFNewsModel mj_objectWithKeyValues:dict];
                    
                    [self.dataList addObject:model];
                    
                    // 存入数据库
                    [[SQLiteManager shareIntance] insertNewsListWithCatId:self.catId model:model];
                }
            }
        }
        
        //刷新banner数据
        [self shuaxinBanner];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];

        [self.tableView reloadData];
    }
    fail:^(NSError *error) {
                             
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        
        [self.tableView.mj_header endRefreshing];
        [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)shuaxinBanner
{
    NSMutableArray *titleArray = [[NSMutableArray alloc]init];
    NSMutableArray *imgViewArray = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < _bannerArray.count; i++) {
        
        YFNewsModel *bannerModel = [_bannerArray objectAtIndex:i];
        
        [titleArray addObject:bannerModel.title];
        
        if (bannerModel.imgUrl) {
            [imgViewArray addObject:[CommonImageUrl stringByAppendingString:bannerModel.imgUrl]];
            
        }
        
        self.bannerView.imageURLStringsGroup = imgViewArray;
        self.bannerView.titlesGroup = titleArray;
    }
}

#pragma mark - 处理banner和cell的数据
- (void)handleBannerAndCellData:(NSArray *)array
{
    if ([self.catId isEqualToString:@"1"]) {
        
        int i = 0;
        for (NSDictionary *dict in array) {
            
            YFNewsModel *model = [YFNewsModel mj_objectWithKeyValues:dict];
            
            if ([model.isTop isEqualToString:@"Y"]) {
                
                i++;
            }
        }
        if (i > 0) {
            
            for (NSDictionary *dict in array) {
                
                YFNewsModel *model = [YFNewsModel mj_objectWithKeyValues:dict];
                
                if ([model.isTop isEqualToString:@"Y"]) {
                    
                    [self.bannerArray addObject:model];
                    
                    // 存入数据库
                    [[SQLiteManager shareIntance] insertNewsListWithCatId:self.catId model:model];
                }
                else
                {
                    [self.dataList addObject:model];
                    
                    // 存入数据库
                    [[SQLiteManager shareIntance] insertNewsListWithCatId:self.catId model:model];
                }
            }
            return;
        }
    }
    //如果数据大于3条
    if (array.count >= 3) {
        
        NSArray *bannerArray = [array subarrayWithRange:NSMakeRange(0, 3)];
        for (NSDictionary *dict in bannerArray) {
            
            YFNewsModel *model = [YFNewsModel mj_objectWithKeyValues:dict];
            [self.bannerArray addObject:model];
            
            // 存入数据库
            [[SQLiteManager shareIntance] insertNewsListWithCatId:self.catId model:model];
        }
        
        NSArray *infoArray = [array subarrayWithRange:NSMakeRange(3, array.count-3)];
        for (NSDictionary *dict in infoArray) {
            
            YFNewsModel *model = [YFNewsModel mj_objectWithKeyValues:dict];
            
            [self.dataList addObject:model];
            
            // 存入数据库
            [[SQLiteManager shareIntance] insertNewsListWithCatId:self.catId model:model];
        }
    }
    //如果数据小于3条
    else
    {
        NSArray *bannerArray = [array subarrayWithRange:NSMakeRange(0, array.count)];
        
        for (NSDictionary *dict in bannerArray) {
            
            YFNewsModel *model = [YFNewsModel mj_objectWithKeyValues:dict];
            [self.bannerArray addObject:model];
            
            // 存入数据库
            [[SQLiteManager shareIntance] insertNewsListWithCatId:self.catId model:model];
        }
        
    }
}

- (void)setCatId:(NSString *)catId
{
    _catId = catId;
}

#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFNewsModel *model = self.dataList[indexPath.row];
    
    YFNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YFNewsTableViewCell"];
    
    if (!cell) {
        
        cell = [[YFNewsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YFNewsTableViewCell"];
    }
    
    cell.newsModel = model;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
