//
//  HttpTool.h
//  AlertViewDemo
//
//  Created by zx on 15/12/10.
//  Copyright © 2015年 yunfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlertControllerTool : NSObject

/**
 *  封装系统的AlertController
 *
 *  @param title 警示框的标题
 *  @param message   警示框的内容
 *  @param alertConrollerStyle 警示框的类型（UIAlertControllerStyleActionSheet UIAlertControllerStyleAlert)
 *  @param cancleBtnTitle 警示框的取消按钮标题
 *  @param otherBtnsTitleArray  警示框其他按钮标题数组
 *  @param CancelAction  取消按钮的回调
 *  @param OtherAction  其他按钮的回调
 */


+(void)AlertControllerActionWithTitle:(NSString *)title Message:(NSString *)message AlertControllerStyle:(UIAlertControllerStyle)alertConrollerStyle CancelBtnTitle:(NSString *)cancleBtnTitle OtherBtnsTitleArray:(NSMutableArray*)otherBtnsTitleArray CancelBtnHandler:(void(^)())CancelAction OtherBtnsHandler:(void(^)(int selectedIndex,NSString *selectedBtnTitle))OtherAction;

@end
