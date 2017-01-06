//
//  SQLiteManager.m
//  base_project
//
//  Created by zyh on 17/1/5.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "SQLiteManager.h"
#import "FMDB.h"
#import "YFNewsModel.h"

@interface SQLiteManager()

@end

static FMDatabase *db;
static SQLiteManager *manager = nil;

@implementation SQLiteManager

+ (instancetype)shareIntance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[SQLiteManager alloc] init];
        
        [manager createdDB];
    });
    
    return manager;
}

- (void)createdDB
{
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = [doc stringByAppendingPathComponent:@"base_project.sqlite"];
    
    NSLog(@"filePath%@",filePath);
    
    db = [FMDatabase databaseWithPath:filePath];
}

- (void)createTable:(tableType)tableType
{
    if (![db open]) {
        
        NSLog(@"数据库打开失败");
        return;
    }
    
    switch (tableType) {
        case newsTypeTable:
            
            [self createTableWithSQL:@"CREATE TABLE IF NOT EXISTS 't_newsType' ('id' integer PRIMARY KEY AUTOINCREMENT, 'catId' TEXT, 'catName' TEXT)"];
            
            break;
        case newsListTable:
            
            [self createTableWithSQL:@"CREATE TABLE IF NOT EXISTS 't_newsList' ('id' integer PRIMARY KEY AUTOINCREMENT, 'addTime' TEXT, 'articleId' TEXT,'articleType' TEXT,'catName' TEXT,'clickCount' TEXT,'content' TEXT,'desc' TEXT,'imgUrl' TEXT,'isTop' TEXT,'parentCatId' TEXT,'title' TEXT, 'catId' TEXT)"];
            break;
        default:
            break;
    }
}

- (void)createTableWithSQL:(NSString *)sql
{
    BOOL result = [db executeUpdate:sql];
    
    if (result) {
        
        NSLog(@"创建成功");
    }else
    {
        NSLog(@"创建失败");
    }
}

- (void)eraseTable:(tableType)tableType
{
    switch (tableType) {
        case newsTypeTable:
            
            [db executeUpdate:@"DELETE FROM 't_newsType'"];
            break;
        case newsListTable:
            
            [db executeUpdate:@"DELETE FROM 't_newsList'"];
            break;
        default:
            break;
    }
}

- (void)eraseNewsTableWithCatId:(NSString *)catId
{
    [db executeUpdate:@"DELETE * FROM t_newsList WHERE catId = '%@';",catId];
}

- (void)insertSQL:(NSString *)sql
{
    if ([db executeUpdate:sql]) {
        
        NSLog(@"");
    }else
    {
        NSLog(@"");
    }
}


- (void)insertNewsListWithCatId:(NSString *)catId model:(YFNewsModel *)model
{
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO t_newsList (addTime, articleId,articleType,catName,clickCount,content,desc,imgUrl,isTop,parentCatId,title,catId) VALUES ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@','%@', '%@');", model.addTime,model.articleId,model.articleType,model.catName,model.clickCount,model.content,model.desc,model.imgUrl,model.isTop,model.parentCatId,model.title,catId];
    
    [db executeUpdate:sql];
}

- (NSArray *)quertyNewsListWithCatId:(NSString *)catId
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM t_newsList WHERE catId = '%@';",catId];
    
    FMResultSet *set = [db executeQuery:sql];
    
    while ([set next]) {
        
        YFNewsModel *model = [[YFNewsModel alloc] init];
        
        model.addTime = [set stringForColumn:@"addTime"];
        model.articleId = [set stringForColumn:@"articleId"];
        model.articleType = [set stringForColumn:@"articleType"];
        model.catName = [set stringForColumn:@"catName"];
        model.clickCount = [set stringForColumn:@"clickCount"];
        model.content = [set stringForColumn:@"content"];
        model.desc = [set stringForColumn:@"desc"];
        model.imgUrl = [set stringForColumn:@"imgUrl"];
        model.isTop = [set stringForColumn:@"isTop"];
        model.parentCatId = [set stringForColumn:@"parentCatId"];
        model.title = [set stringForColumn:@"title"];
        model.catId = [set stringForColumn:@"catId"];
        
        [array addObject:model];
    }
    
    return [array copy];
}

- (NSMutableArray *)quertyNewsTypeSQL:(NSString *)sql
{
    FMResultSet *set = [db executeQuery:sql];
    
    NSMutableArray *array = [NSMutableArray array];
    NSMutableArray *catIdArray = [NSMutableArray array];
    NSMutableArray *catNameArray = [NSMutableArray array];
    
    int count = [set columnCount];
    
    for (int i = 0; i < count; i++) {
        
        set = [db executeQuery:sql];
        
        while ([set next]) {
            
            NSString *key = [set columnNameForIndex:i];
            NSString *value = [set stringForColumn:key];
            
            if ([key isEqualToString:@"catId"]) {
                
                [catIdArray addObject:value];
            }else
            {
                [catNameArray addObject:value];
            }
            
        }
    }

    [array addObject:catIdArray];
    [array addObject:catNameArray];

    return array;
}

@end
