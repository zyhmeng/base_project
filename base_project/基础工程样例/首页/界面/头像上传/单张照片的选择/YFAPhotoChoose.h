//
//  YFAPhotoChoose.h
//  base_project
//
//  Created by zyh on 16/12/22.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^chooseImage)(UIImage *image);

@interface YFAPhotoChoose : NSObject

+ (void)choosePhotoWithObject:(UIViewController *)object chooseImage:(void (^)(UIImage *image))chooseImage;
@end
