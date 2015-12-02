//
//  Common.h
//  IOSTrain
//
//  Created by jangbuk on 15/8/13.
//  Copyright (c) 2015年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MJRefresh/Custom/Header/MJRefreshGifHeader.h"
#import "MJRefresh/Custom/Footer/Auto/MJRefreshAutoGifFooter.h"

#import <CommonCrypto/CommonCrypto.h>
@interface Common : NSObject

//判断是否成功请求
+(BOOL)IsRequestSuccess:(id)response_object;

//获取请求提示消息
+(NSString *)GetResponseMSG:(id)response_object;

//获取业务数据
+(id)GetResponseData:(id)response_object ByKey:(NSString *)key;

//通过入参的 url 及 字典 生成请求数据的 md5 校验码
+(NSString*)GetMD5ByUrlName:(NSString *)url Dictionary:(NSDictionary *)dic;

//判断手机号
+(BOOL)CheckIsTelNum:(NSString *)str;

//判断密码
+(BOOL)CheckIsIncludeNumAndWord:(NSString *)str;

//设置NAV BAR
+(void)SetNav:(UINavigationBar *)bar;

//IOS 7/8 通用获取是否包含字符
+(BOOL)myString:(NSString *)string ContainsString:(NSString*)other;

//画线
+(void)DrowLineAtImageView:(UIImageView *)image_view StartPoint:(CGPoint )line_start_pt EndPoint:(CGPoint )line_end_pt Color:(UIColor *)line_color LineWidth:(float)line_width;

//颜色 16进制 转 UIColor
+ (UIColor *) colorWithHexString: (NSString *)color;

//UIColor 转 UIImage
+ (UIImage *)createImageWithColor:(UIColor *)color;

//字符串转时间
+(NSDate *)dateFromString:(NSString *)dateString;

//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath;

//是否包含emoji字符
+ (BOOL)stringContainsEmoji:(NSString *)string;

//添加GifHeader下拉刷新
+(MJRefreshGifHeader*)AddGifHeaderAndLoadDataFinished:(void (^)())finished;

//判断输入的密码项
+(BOOL)CheckPWByOnce:(NSString *)OncePW TwicePW:(NSString *)TwicePW;

@end


