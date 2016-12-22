//
//  YFPhotoModel.m
//  base_project
//
//  Created by zyh on 16/12/21.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFPhotoModel.h"

static int margin = 10;
static int photoHeight = 100;

@implementation YFPhotoModel

- (CGFloat)photoViewHeight
{
    if (self.photoUrlArray.count == 1) {
        
        _photoViewHeight = UISCREENWIDTH - 20 + margin;

    }else if (self.photoUrlArray.count)
    {
        _photoViewHeight = (self.photoUrlArray.count/3)*(photoHeight + margin) + photoHeight + margin;
        
        if (self.photoUrlArray.count == 3) {
            
            _photoViewHeight = photoHeight + margin;
            
        }if (self.photoUrlArray.count == 6) {
            
            _photoViewHeight = (photoHeight + margin) * 2;
            
        }if (self.photoUrlArray.count == 9) {
            
            _photoViewHeight = (photoHeight + margin) * 3;
        }
    }
    
    return _photoViewHeight;
}

@end
