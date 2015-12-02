//
//  CommonViewController.m
//  wuse
//
//  Created by jangbuk on 15/8/21.
//  Copyright (c) 2015年 jangbuk. All rights reserved.
//

#import "CommonViewController.h"

@interface CommonViewController ()


@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //初始化nav样式
    [self SetNav:self.navigationController.navigationBar];
    //初始化nav左侧右侧按钮
    [self SetNavBarBtnItems];
    


}

#pragma mark--设置Nav样式
-(void)SetNav:(UINavigationBar*)bar
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    [bar setBackgroundImage:[Common createImageWithColor:[UIColor blackColor]]forBarMetrics:UIBarMetricsDefault];
   // [bar setBackgroundColor:[UIColor blackColor]];
    bar.alpha=1;
    [bar setTranslucent:NO];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
}

-(void)SetNavBarBtnItems
{

  //  self.navigationItem.titleView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"nav_center"]];
    
    UIColor * color = [UIColor whiteColor];
    

    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:UITextAttributeTextColor];

    self.navigationController.navigationBar.titleTextAttributes = dict;
    
    
    //左侧返回
    self.navBackBT = [[UIButton alloc] initWithFrame:CGRectMake(0,0,50,25)];
    [self.navBackBT setTitle:@"返回" forState:UIControlStateNormal];
    //self.navBackBT.titleLabel.font = [UIFont systemFontOfSize:14];

    //图片
    [self.navBackBT setBackgroundImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [self.navBackBT addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barLeftItem  = [[UIBarButtonItem alloc] initWithCustomView:self.navBackBT];
    
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeSpacer.width = -5;
    
    self.navigationItem.leftBarButtonItems = [NSArray arrayWithObjects:negativeSpacer, barLeftItem, nil];
    //或者
    //self.navigationItem.leftBarButtonItem = btn;
    
    
    
    //右侧按钮
    
    self.navRightBT = [[UIButton alloc] initWithFrame:CGRectMake(0,0,25,25)];
   // [self.navRightBT setTitle:@"返回" forState:UIControlStateNormal];
    //self.navRightBT.titleLabel.font = [UIFont systemFontOfSize:14];
    
    //图片
    [self.navRightBT setBackgroundImage:[UIImage imageNamed:@"nav_member"] forState:UIControlStateNormal];

    UIBarButtonItem *barRightItem  = [[UIBarButtonItem alloc] initWithCustomView:self.navRightBT];
    
    /**
     *  width为负数时，相当于btn向右移动width数值个像素，由于按钮本身和边界间距为5pix，所以width设为-5时，间距正好调整
     *  为0；width为正数时，正好相反，相当于往左移动width数值个像素
     */
    UIBarButtonItem *negativeRightSpacer = [[UIBarButtonItem alloc]
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                       target:nil action:nil];
    
    negativeRightSpacer.width = 0;
    
    self.navigationItem.rightBarButtonItems = [NSArray arrayWithObjects:negativeRightSpacer, barRightItem, nil];
}

-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark--隐藏状态栏
/*
- (BOOL)prefersStatusBarHidden

{
    return YES;
}
 */


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleBlackTranslucent;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
