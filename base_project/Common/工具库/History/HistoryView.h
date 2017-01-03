//
//  HistoryView.h
//  HistoryDemo
//
//  Created by 润泰－技术部 on 16/4/2.
//  Copyright © 2016年 ruitaiLong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HistoryViewDelegate <NSObject>

@optional
- (void)onClickCancelWithTag:(NSInteger)tag;

- (void)selectItemWithTag:(NSInteger)tag;

@end

@interface HistoryView : UIView <UIScrollViewDelegate>

@property (strong ,nonatomic)NSMutableArray * historyDataArray;
@property (assign ,nonatomic)id<HistoryViewDelegate>delegate;

- (void)reloadData;

@end
