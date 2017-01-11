//
//  YLImageBrowser.m
//
//  Created by Yin on 15/6/1.
//  Copyright (c) 2015年 Apple. All rights reserved.
//

#import "YLImageBrowser.h"


static CGRect oldFrame;

@implementation YLImageBrowser

+ (void)fullscreenView:(UIView *)view
{
	UIImage* image=nil;
	if([view isKindOfClass:[UIImageView class]])
	{
		image=[(UIImageView*)view image];
	}
	else if([view isKindOfClass:[UIButton class]])
	{
		image=[(UIButton*)view backgroundImageForState:UIControlStateNormal];
	}

	if(image==nil) return;
	UIWindow *window=[UIApplication sharedApplication].keyWindow;
	oldFrame=[view convertRect:view.bounds toView:window];

	UIView *backgroundView=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	backgroundView.backgroundColor=[UIColor blackColor];
	backgroundView.alpha=0;

	UIImageView *newIV=[[UIImageView alloc] initWithFrame:oldFrame];
	newIV.image=image;
	newIV.tag=1;

	[backgroundView addSubview:newIV];
	[window addSubview:backgroundView];

	UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
	[backgroundView addGestureRecognizer:tapGesture];

	[UIView animateWithDuration:0.3 animations:^{
		newIV.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
		backgroundView.alpha=1;
	} completion:^(BOOL finished) {
	}];
}

+ (void)fullscreenButton:(UIButton *)button
{
	[self fullscreenView:button];
}

+ (void)fullscreenImageView:(UIImageView *)imageView
{
	[self fullscreenView:imageView];
//	UIImage *image=imageView.image;
//	if(image==nil) return;
//
//	UIWindow *window=[UIApplication sharedApplication].keyWindow;
//	oldFrame=[imageView convertRect:imageView.bounds toView:window];
//
//	UIView *backgroundView=[[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
//	backgroundView.backgroundColor=[UIColor blackColor];
//	backgroundView.alpha=0;
//
//	UIImageView *newIV=[[UIImageView alloc] initWithFrame:oldFrame];
//	newIV.image=image;
//	newIV.tag=1;
//
//	[backgroundView addSubview:newIV];
//	[window addSubview:backgroundView];
//
//	UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideImage:)];
//	[backgroundView addGestureRecognizer:tapGesture];
//
//	[UIView animateWithDuration:0.3 animations:^{
//		newIV.frame=CGRectMake(0,([UIScreen mainScreen].bounds.size.height-image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width)/2, [UIScreen mainScreen].bounds.size.width, image.size.height*[UIScreen mainScreen].bounds.size.width/image.size.width);
//		backgroundView.alpha=1;
//	} completion:^(BOOL finished) {
//	}];
}

+ (void)hideImage:(UITapGestureRecognizer *)tapGesture
{
	//注意：tapGesture.view不一定是ImageView，也可能是Button，只不过现在没有用到Button的属性而已
	UIView *backgroundView=tapGesture.view;
	UIImageView *imageView=(UIImageView*)[tapGesture.view viewWithTag:1];
	[UIView animateWithDuration:0.3 animations:^{
		imageView.frame=oldFrame;
		backgroundView.alpha=0;
	} completion:^(BOOL finished) {
		[backgroundView removeFromSuperview];
	}];
}

@end
