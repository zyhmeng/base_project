//
//  YFNewsModel.h
//  base_project
//
//  Created by zyh on 16/12/29.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFNewsModel : NSObject

@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *articleId;
@property (nonatomic, strong) NSString *imgUrl;
@property (nonatomic, strong) NSString *clickCount;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSString *articleType;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *catId;
@property (nonatomic, strong) NSString *catName;
@property (nonatomic, strong) NSString *isTop;
@property (nonatomic, assign) int pageNum;
@property (nonatomic, strong) NSString *parentCatId;

@end
