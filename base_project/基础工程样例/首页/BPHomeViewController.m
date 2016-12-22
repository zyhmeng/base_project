//
//  BPHomeViewController.m
//  base_project
//
//  Created by jangbuk on 16/9/21.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "BPHomeViewController.h"
#import "YFPhotoShowViewController.h"

@interface BPHomeViewController ()<UITableViewDelegate,UITableViewDataSource>

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
        
    }
}

@end
