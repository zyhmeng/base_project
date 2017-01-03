//
//  YFAPhotoChoose.m
//  base_project
//
//  Created by zyh on 16/12/22.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFAPhotoChoose.h"
#import "UIActionSheet+Blocks.h"
#import "RIButtonItem.h"

@interface YFAPhotoChoose()

@property (nonatomic, strong) UIImage *image;

@end

@implementation YFAPhotoChoose

+ (void)choosePhotoWithObject:(UIViewController *)object chooseImage:(void (^)(UIImage *))chooseImage
{
    [[[UIActionSheet alloc] initWithTitle:nil cancelButtonItem:[RIButtonItem itemWithLabel:@""] destructiveButtonItem:nil otherButtonItems:[RIButtonItem itemWithLabel:@"拍照" action:^{
        
        //打开照相机拍照
        
        
    }], [RIButtonItem itemWithLabel:@"从手机相册选择" action:^{
        
    }],nil] showInView:object.view];
}


@end
