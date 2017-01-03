//
//  YFPhotoShowViewController.m
//  base_project
//
//  Created by zyh on 16/12/14.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFPhotoShowViewController.h"
#import "YFPhotoShowCell.h"
#import "YFPhotoShowView.h"
#import "YFPhotoModel.h"

@interface YFPhotoShowViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSMutableArray <YFPhotoModel *> *dataArray;

@end

@implementation YFPhotoShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"九宫格图片显示"];
    
    [self setupTableView];
    
    self.dataList = [NSArray array];
    
    self.dataList = @[@"http://pic33.nipic.com/20130916/3420027_192919547000_2.jpg",@"http://img03.tooopen.com/images/20131102/sy_45238929299.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/01/0E/ChMkJlbKwaOIN8zJAAs5DadIS-IAALGbQPo5ngACzkl365.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/01/0E/ChMkJlbKwhKIXmKmABXUcO-fCzIAALGiQKzwv4AFdSI694.jpg",@"http://image101.360doc.com/DownloadImg/2016/10/2813/83246025_16.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/02/03/ChMkJ1bKxpWIIp3vAAimMffVdTgAALHnQMKJY0ACKZJ164.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g4/M00/0D/01/Cg-4y1ULoXCII6fEAAeQFx3fsKgAAXCmAPjugYAB5Av166.jpg",@"http://image101.360doc.com/DownloadImg/2016/10/2719/83195451_16.jpg",@"http://desk.fd.zol-img.com.cn/t_s960x600c5/g5/M00/01/0E/ChMkJlbKwhKIPf_RAAweZKvhDqMAALGiQLPZ9QADB58872.jpg"];
    
    self.dataArray = [NSMutableArray array];
    
    for (int i = 0; i < 9; i++) {
        
        YFPhotoModel *model = [[YFPhotoModel alloc] init];
        
        model.photoUrlArray = [self.dataList subarrayWithRange:NSMakeRange(0, i+1)];
        
        [self.dataArray addObject:model];
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)setupTableView
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, UISCREENWIDTH, UISCREENHEIGHT) style:UITableViewStyleGrouped];
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    [tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YFPhotoShowCell class]) bundle:nil] forCellReuseIdentifier:@"YFPhotoShowCell"];
    
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataArray[indexPath.row].photoViewHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YFPhotoShowCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YFPhotoShowCell"];
    
    if (!cell) {
        
        cell = [[YFPhotoShowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"YFPhotoShowCell"];
    }
    
    cell.photoView.photoArray = self.dataArray[indexPath.row].photoUrlArray;
    
    return cell;
}

@end
