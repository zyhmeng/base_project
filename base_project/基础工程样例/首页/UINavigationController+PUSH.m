//
//  UINavigationController+PUSH.m
//  base_project
//
//  Created by jangbuk on 16/9/21.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "UINavigationController+PUSH.h"

@implementation UINavigationController (PUSH)
-(void)MypushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    /*
    [button setImage:[UIImage imageNamed:@"navigationButtonReturn"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"navigationButtonReturnClick"] forState:UIControlStateHighlighted];
*/
    [button setFrame:CGRectMake(0, 0, 70, 30)];
    //size = CGSizeMake(70, 30);
    // 让按钮内部的所有内容左对齐
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    //        [button sizeToFit];
    // 让按钮的内容往左边偏移10
    button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0);
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(MYpopViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    // 修改导航栏左边的item
    viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    // 隐藏tabbar
    //viewController.hidesBottomBarWhenPushed = YES;
    
    [self backSelectedButton:button];
    
    [self pushViewController:viewController animated:YES];
    NSLog(@"hahah");
    
}
-(UIButton *)backSelectedButton:(UIButton *)btn
{
    return btn;
}

-(UIViewController *)MYpopViewControllerAnimated:(BOOL)animated
{
    
    return [self popViewControllerAnimated:animated];
}
@end
