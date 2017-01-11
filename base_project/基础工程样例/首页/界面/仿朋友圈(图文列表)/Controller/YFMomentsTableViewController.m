//
//  YFMomentsTableViewController.m
//  base_project
//
//  Created by zyh on 17/1/10.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFMomentsTableViewController.h"
#import "YFMomentsModel.h"
#import "YFMomentsCell.h"

@interface YFMomentsTableViewController ()

@property (nonatomic, assign) int pageNo;

@property (nonatomic, strong) NSMutableArray <YFMomentsModel *> *dataList;

@end

@implementation YFMomentsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"仿朋友圈"];

    [self setupTableView];
    
    [self requestDataList];
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)setupTableView
{
    self.dataList = [NSMutableArray array];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YFMomentsCell class]) bundle:nil] forCellReuseIdentifier:@"cellId"];
}

- (void)requestDataList
{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    [dict setObject:@"9554" forKey:@"cmd"];
    [dict setObject:[NSString stringWithFormat:@"%ld",(long)self.pageNo] forKey:@"pageNo"];
    [dict setObject:@"10" forKey:@"pageSize"];
    
    [YFNetworking postWithUrl:nil refreshCache:YES params:dict success:^(id response) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
        if ([Common IsRequestSuccess:response]) {
            
            if (self.pageNo == 0) {
                
                [self.dataList removeAllObjects];
            }
            
            NSArray *array = [Common GetRequestResultFromResponse:response];
            
            for (NSDictionary *dict in array) {
                
                YFMomentsModel *model = [YFMomentsModel mj_objectWithKeyValues:dict];
                
                [self.dataList addObject:model];
            }
            
            [self.tableView reloadData];
        }
        
    } fail:^(NSError *error) {
        
        [MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.tableView.mj_footer endRefreshing];
        [self.tableView.mj_header endRefreshing];
        
    }];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.dataList[indexPath.row].cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *identifier = @"cellId";
    
    YFMomentsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    YFMomentsModel *model = self.dataList[indexPath.row];
    
    cell.model = model;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
