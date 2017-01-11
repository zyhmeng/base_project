//
//  YFMomentsModel.h
//  base_project
//
//  Created by zyh on 17/1/10.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFMomentsModel : NSObject

@property (nonatomic, strong) NSString *blogId;
@property (nonatomic, strong) NSString *blogUserId;
@property (nonatomic, strong) NSString *imageStr;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *content;
@property (nonatomic, strong) NSArray *pictureArray;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *supportCount;
@property (nonatomic, strong) NSString *articleType;
@property (nonatomic, strong) NSString *likeFlag;
@property (nonatomic, strong) NSString *circleName;
@property (nonatomic, strong) NSString *circleId;
@property (nonatomic, strong) NSString *commentCount;
@property (nonatomic, strong) NSString *shareUrlStr;
@property (nonatomic, strong) NSString *shareTitle;

//扩展属性
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect pictureViewFrame;

@end
