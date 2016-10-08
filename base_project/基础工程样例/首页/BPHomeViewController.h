//
//  BPHomeViewController.h
//  base_project
//
//  Created by jangbuk on 16/9/21.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UINavigationController+PUSH.h"
#import "PayAction.h"
@interface BPHomeViewController : UIViewController<UITabBarControllerDelegate>


- (IBAction)WeiXinPay:(id)sender;

- (IBAction)AliPay:(id)sender;
@end
