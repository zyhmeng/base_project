//
//  YFMomentsModel.m
//  base_project
//
//  Created by zyh on 17/1/10.
//  Copyright © 2017年 jangbuk. All rights reserved.
//

#import "YFMomentsModel.h"
#import "NSString+Extension.h"

static int margin = 10;
static int pictureHeight = 100;
@implementation YFMomentsModel

+ (void)initialize
{
    [YFMomentsModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
        
        return @{@"blogId":@"blogId",
                 @"circleName":@"catName",
                 @"blogUserId":@"userId",
                 @"name":@"alias",
                 @"articleType":@"articleType",
                 @"shareUrlStr":@"linkUrl",
                 @"content":@"content",
                 @"supportCount":@"likeCount",
                 @"commentCount":@"commentCount",
                 @"name":@"alias",
                 @"imageStr":@"userImg",
                 @"pictureArray":@"imgs",
                 @"circleId":@"catId",
                 @"time":@"addTime"
                 };
    }];
}

- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    _cellHeight = 60;//content的Y值
    
    //文字
    CGSize size = [self.content sizeWithFont:[UIFont systemFontOfSize:15] maxWidth:UISCREENWIDTH-20];
    
    // 处理详情和不是详情的cell高度
    if (size.height > 60) {
        
        _cellHeight += 60 + margin;
    }else
    {
        _cellHeight += size.height + margin;
    }
    
    if ([self.articleType isEqualToString:@"txt"]) {
        
        //图片
        if (self.pictureArray.count == 1){
            
            self.pictureViewFrame = CGRectMake(10, _cellHeight, UISCREENWIDTH - 20, UISCREENWIDTH - 20);
            _cellHeight += UISCREENWIDTH - 20 + margin;
            
        }
        else if(self.pictureArray.count > 1){
            
            CGFloat pictureViewH = (self.pictureArray.count/3)*(pictureHeight + margin) + pictureHeight;
            
            if (self.pictureArray.count == 3) {
                
                pictureViewH = pictureHeight;
                
            }else if (self.pictureArray.count == 6)
            {
                pictureViewH = (pictureHeight + margin) * 2;
                
            }else if (self.pictureArray.count == 9)
            {
                pictureViewH = (pictureHeight + margin) * 3;
            }
            
            self.pictureViewFrame = CGRectMake(10, _cellHeight, UISCREENWIDTH - 20, pictureViewH);
            
            _cellHeight += pictureViewH + margin;
            
        }
    }

    return _cellHeight;
}

@end
