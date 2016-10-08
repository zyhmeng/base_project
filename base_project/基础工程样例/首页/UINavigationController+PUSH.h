//
//  UINavigationController+PUSH.h
//  base_project
//
//  Created by jangbuk on 16/9/21.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (PUSH)

-(UIButton *)backSelectedButton:(UIButton *)btn;

-(void)MypushViewController:(UIViewController *)viewController animated:(BOOL)animated;

@end
