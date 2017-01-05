//
//  YFUIKitAnimationViewController.m
//  base_project
//
//  Created by zyh on 17/1/4.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFUIKitAnimationViewController.h"
#import "UIColor+CustomColors.h"

@interface YFUIKitAnimationViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation YFUIKitAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setTitle:@"UIKit动效"];
    
    [self setupLoginBtn];
}

- (void)setupLoginBtn
{
    self.loginBtn.backgroundColor = [UIColor customBlueColor];
    
    self.loginBtn.layer.cornerRadius = 5;
    
    [self.loginBtn addTarget:self action:@selector(loginBtnClick) forControlEvents:UIControlEventTouchUpInside];
}

- (void)loginBtnClick
{
    POPSpringAnimation *spingAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionX];
    
    spingAnimation.velocity = @2000;
    spingAnimation.springBounciness = 20.0;
    
    [self.loginBtn.layer pop_addAnimation:spingAnimation forKey:@"positionX"];
}

- (IBAction)buttonClicked:(UIButton *)sender {
    
    POPSpringAnimation *animation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
    
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
    
    animation.velocity = [NSValue valueWithCGPoint:CGPointMake(12, 12)];
    
    [sender pop_addAnimation:animation forKey:@"viewSize"];
}

@end
