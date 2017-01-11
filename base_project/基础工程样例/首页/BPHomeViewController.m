//
//  BPHomeViewController.m
//  base_project
//
//  Created by jangbuk on 16/9/21.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "BPHomeViewController.h"
#import "YFPhotoShowViewController.h"
#import "UIActionSheet+Blocks.h"
#import "RIButtonItem.h"
#import "YFAPhotoChooseViewController.h"
#import "YFHotSearchViewController.h"
#import "YFPieChartViewController.h"
#import "YFNewsViewController.h"
#import "YFRichTextViewController.h"
#import "YFUIKitViewController.h"
#import "YFUIKitAnimationViewController.h"
#import "YFMomentsTableViewController.h"

@interface BPHomeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>

@property (strong, nonatomic) IBOutlet UITableView *MainFuncTableView;

@property (strong, nonatomic) NSMutableArray *funcList;

@end

@implementation BPHomeViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"FuncList" ofType:@"plist"];
    
    self.funcList= [[NSMutableArray alloc] initWithContentsOfFile:plistPath];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)WeiXinPay:(id)sender
{
    int x = arc4random() % 10000000;
    NSString *TradeNum=[NSString stringWithFormat:@"ForTest%d",x];
    
    [PayAction WeChatPayActionByTradeNo:TradeNum OrderName:@"供测试" andPrice:@"1"];
}

- (IBAction)AliPay:(id)sender
{
    int x = arc4random() % 10000000;
    NSString *TradeNum=[NSString stringWithFormat:@"ForTest%d",x];
    
    [PayAction AliPayActionByTradeNo:TradeNum ProductDesc:@"供测试" ProductName:@"苹果手机" Amount:@"0.01" success:^(NSString *success) {
        
        NSLog(@"%@",success);
    } failure:^(NSString *error) {
        NSLog(@"%@",error);
    }];
}


#pragma mark--UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.funcList objectAtIndex:section] objectForKey:@"list"] count];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.funcList.count;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return [[self.funcList objectAtIndex:section] objectForKey:@"desc"];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[[UITableViewCell alloc] init];
    
    NSString *abc=
    [[[[self.funcList objectAtIndex:indexPath.section]objectForKey:@"list"] objectAtIndex:indexPath.row] objectForKey:@"name"];
   
    
    cell.textLabel.text=abc;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        YFPhotoShowViewController *photoShowVC = [[YFPhotoShowViewController alloc]init];
        
        [self.navigationController pushViewController:photoShowVC animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 1)
    {
        /*
       [[[UIActionSheet alloc] initWithTitle:nil cancelButtonItem:[RIButtonItem itemWithLabel:@"取消"] destructiveButtonItem:nil otherButtonItems:[RIButtonItem itemWithLabel:@"选择多张图片" action:^{
            
       }], [RIButtonItem itemWithLabel:@"选择一张图片" action:^{
           
           YFAPhotoChooseViewController *aPhotoVC = [[YFAPhotoChooseViewController alloc] init];
           [self.navigationController pushViewController:aPhotoVC animated:YES];
           
       }], nil] showInView:self.view];*/
        
        YFAPhotoChooseViewController *aPhotoVC = [[YFAPhotoChooseViewController alloc] init];
        
        [self.navigationController pushViewController:aPhotoVC animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 2)
    {
        YFHotSearchViewController *hotSearchVC = [[YFHotSearchViewController alloc] init];
        
        [self.navigationController pushViewController:hotSearchVC animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 3)
    {
        YFPieChartViewController *pieChartVC = [[YFPieChartViewController alloc] init];
        
        [self.navigationController pushViewController:pieChartVC animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 4)
    {
        YFNewsViewController *newsVC = [[YFNewsViewController alloc] init];
        
        [self.navigationController pushViewController:newsVC animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 5)
    {
        YFRichTextViewController *richTextVC = [[YFRichTextViewController alloc] init];
        
        [self.navigationController pushViewController:richTextVC animated:YES];
        
    }else if (indexPath.section == 0 && indexPath.row == 6)
    {
        YFMomentsTableViewController *momentsVC = [[YFMomentsTableViewController alloc] init];
        
        [self.navigationController pushViewController:momentsVC animated:YES];
        
    }
    else if (indexPath.section == 0 && indexPath.row == 7)
    {
        YFUIKitViewController *uikitVC = [[YFUIKitViewController alloc] init];
        
        [self.navigationController pushViewController:uikitVC animated:YES];
        
    }else if (indexPath.section == 1 && indexPath.row == 0)
    {
        SHOW_ALERT_VIEW(@"仿网易新闻首页的离线存储", nil);
    }
    else if (indexPath.section == 2 && indexPath.row == 0)
    {
        YFUIKitAnimationViewController *uikitAnimationVC = [[YFUIKitAnimationViewController alloc] init];
        
        [self.navigationController pushViewController:uikitAnimationVC animated:YES];
    }
}


@end
