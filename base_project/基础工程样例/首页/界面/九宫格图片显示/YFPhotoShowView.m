//
//  YFPhotoShowView.m
//  base_project
//
//  Created by zyh on 16/12/14.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFPhotoShowView.h"
#import "ImageBrowserViewController.h"

static int spaceing = 10;

@implementation YFPhotoShowView

- (void)setPhotoArray:(NSArray *)photoArray
{
    _photoArray = photoArray;
    
    for (UIImageView *imageView in self.subviews) {
        
        [imageView removeFromSuperview];
    }
    
    if (photoArray.count == 1) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, UISCREENWIDTH-20, UISCREENWIDTH - 20)];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:photoArray[0]]];
        
        imageView.userInteractionEnabled = YES;
        
        imageView.tag = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
        
        [imageView addGestureRecognizer:tap];
        
        [self addSubview:imageView];
        
    }else
    {
        for (int i = 0; i < photoArray.count; i++) {
            
            CGFloat width = (UISCREENWIDTH - 20 - spaceing* 3) / 3;
            CGFloat x;
            CGFloat y;
            
            UIImageView *imageView = [[UIImageView alloc]init];
            
            x = (i % 3)*(spaceing + width) + spaceing;
            y = (i / 3)* (spaceing + 100);
            
            imageView.frame = CGRectMake(x, y, width, 100);
            
            imageView.userInteractionEnabled = YES;
            
            imageView.tag = i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
            
            [imageView addGestureRecognizer:tap];
            
            NSString *imageStr = photoArray[i];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:imageStr]];
            
            [self addSubview:imageView];
        }
    }
}

- (void)imageViewTap:(UITapGestureRecognizer *)gesture
{
    __block NSMutableArray *photosArr = [NSMutableArray new];
    for (NSString *url in self.photoArray) {
        
        [photosArr addObject:url];
    }
    
    if ([self getCurrentViewController] != nil) {
        UIViewController * parentVC = [self getCurrentViewController];
        [ImageBrowserViewController show:parentVC type:PhotoBroswerVCTypePush index:gesture.view.tag imagesBlock:^NSArray *{
            return photosArr;
        }];
        
    }
}

-(UIViewController *)getCurrentViewController{
    UIResponder *next = [self nextResponder];
    do {
        if ([next isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    } while (next != nil);
    return nil;
}


@end
