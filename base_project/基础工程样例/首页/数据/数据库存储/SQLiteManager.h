//
//  SQLiteManager.h
//  base_project
//
//  Created by zyh on 17/1/5.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YFNewsModel;
typedef enum : NSUInteger {
    newsListTable,
    newsTypeTable,
} tableType;

@interface SQLiteManager : NSObject

+ (instancetype)shareIntance;

- (void)createTable:(tableType)tableType;

- (void)eraseTable:(tableType)tableType;

- (void)dropNewsListTable;

- (void)eraseNewsTableWithCatId:(NSString *)catId;

- (void)insertSQL:(NSString *)sql;

- (void)insertNewsListWithCatId:(NSString *)catId model:(YFNewsModel *)model;

- (NSArray *)quertyNewsTypeSQL:(NSString *)sql;

- (NSArray *)quertyNewsListWithCatId:(NSString *)catId;
@end
