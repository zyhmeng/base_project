//
//  YFMomentsPictureView.m
//  JianKangGuanLi
//
//  Created by zyh on 16/8/23.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import "YFMomentsPictureView.h"
#import "YLImageBrowser.h"
#import "ImageBrowserViewController.h"

static int spaceing = 10;
static int pictureHeight = 100;

@interface YFMomentsPictureView()

@property (nonatomic, strong) NSString *loadImgUrl;

@end

@implementation YFMomentsPictureView

- (void)setPictureArray:(NSArray *)pictureArray
{
    _pictureArray = pictureArray;
    
    for (UIImageView *imageView in self.subviews) {
        
        [imageView removeFromSuperview];
    }
    
    if(pictureArray.count == 1){
        
        UIImageView *imageView = [[UIImageView alloc]init];
        
        imageView.frame = CGRectMake(0, 0, UISCREENWIDTH - 20, UISCREENWIDTH - 20);
        
        imageView.userInteractionEnabled = YES;
        

        imageView.tag = 0;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
        
        [imageView addGestureRecognizer:tap];
        
        NSString *imageStr = pictureArray[0];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:[CommonImageUrl stringByAppendingString:imageStr]] placeholderImage:[UIImage imageNamed:@"图标占位图140"]];
        
        [self addSubview:imageView];
        
    }
    else
    {
        for (int i = 0; i < pictureArray.count; i++) {
            
            CGFloat width = (UISCREENWIDTH-20-spaceing * 3) / 3.0;
            CGFloat x;
            CGFloat y;
            
            UIImageView *imageView = [[UIImageView alloc]init];
            
            x = (i % 3)*(spaceing + width);
            y = (i / 3)* (spaceing + pictureHeight);
            
            imageView.frame = CGRectMake(x, y, width, pictureHeight);
            
            imageView.userInteractionEnabled = YES;
            
            imageView.tag = i;
            
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
            
            [imageView addGestureRecognizer:tap];
            
            NSString *imageStr = pictureArray[i];
            
            NSArray *array = [imageStr componentsSeparatedByString:@"."];
            
            NSString *str0 = array[0];
            NSString *str1 = array[1];
            
            NSString *miniStr = [str0 stringByAppendingString:@"_mini."];
            
            NSString *imgUrl = [miniStr stringByAppendingString:str1];
            
            [imageView sd_setImageWithURL:[NSURL URLWithString:[CommonImageUrl stringByAppendingString:imgUrl]] placeholderImage:[UIImage imageNamed:@"图标占位图140"]];
            
            [self addSubview:imageView];
        }
    }
}

- (void)imageViewTap:(UITapGestureRecognizer *)gesture
{
    __block NSMutableArray *photosArr = [NSMutableArray new];
    for (NSString *url in self.pictureArray) {
        NSString  *URL = [CommonImageUrl stringByAppendingString:url];
        [photosArr addObject:URL];
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
