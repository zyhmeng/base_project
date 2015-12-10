//
//
//  Created by zx on 15/12/10.
//  Copyright © 2015年 yunfeng. All rights reserved.
//

#import "AlertControllerTool.h"

@interface AlertControllerTool ()

@end

@implementation AlertControllerTool

+(void)AlertControllerActionWithTitle:(NSString *)title Message:(NSString *)message AlertControllerStyle:(UIAlertControllerStyle)alertConrollerStyle CancelBtnTitle:(NSString *)cancleBtnTitle OtherBtnsTitleArray:(NSMutableArray*)otherBtnsTitleArray CancelBtnHandler:(void(^)())CancelAction OtherBtnsHandler:(void(^)(int selectedIndex,NSString *selectedBtnTitle))OtherAction
{
    
    UIAlertController *alertcontroller=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:alertConrollerStyle];
    
    UIAlertAction *actionOne=[UIAlertAction actionWithTitle:cancleBtnTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        CancelAction();
    }];
    [alertcontroller addAction:actionOne];
    
    for (int i=0; i<otherBtnsTitleArray.count; i++) {
         UIAlertAction *actionOther=[UIAlertAction actionWithTitle:otherBtnsTitleArray[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
             OtherAction(i,otherBtnsTitleArray[i]);
         }];
        [alertcontroller addAction:actionOther];
    }
    
    [[self getCurrentVC] presentViewController:alertcontroller animated:YES completion:nil];
    
}


//获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
