//
//  HistoryItem.h
//  HistoryDemo
//
//  Created by 润泰－技术部 on 16/4/2.
//  Copyright © 2016年 ruitaiLong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryItem : UIView

- (id)initWithString:(NSString *)str WithFrame:(CGRect)frame;
/**
 *  取消按钮
 */
@property (strong ,nonatomic)UIButton * cancelButton;

- (void)addtapGesWithtarget:(id)target action:(SEL)select;

@end
