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


//解析返回的数据
+ (id)GetRequestResultFromResponse:(id)response;

//解析返回错误码
+ (NSString *)GetErrorStrFromResponse:(id)response;

//判断是否成功请求
+(BOOL)IsRequestSuccess:(id)response_object;

//获取请求提示消息
+(NSString *)GetResponseMSG:(id)response_object;

//获取请求提示消息码
+(NSNumber *)GetResponseCode:(id)response_object;

//获取业务数据
+(id)GetResponseData:(id)response_object ByKey:(NSString *)key;

//通过入参的 url 及 字典 生成请求数据的 md5 校验码
+(NSString*)GetMD5ByUrlName:(NSString *)url Dictionary:(NSDictionary *)dic;

//判断手机号
+(BOOL)CheckIsTelNum:(NSString *)str;

//校验身份证号
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard;

//判断email
+(BOOL)isValidateEmail:(NSString *)email;

//判断密码
+(BOOL)CheckIsIncludeNumAndWord:(NSString *)str;

//判断密码的格式是否包含字母和数字
+(BOOL)judgeSafeStringLegal:(NSString *)pass;

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

//md5加密
+(NSString *) md5: (NSString *) inPutText;

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

//判断字符串是否为空
+ (BOOL)stringIsEmpty:(NSString *)string;

//两个时间差
+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2;

// 根据字体大小多少计算尺寸
+ (CGRect)computeTextRectWith:(NSString *)text  andTextFont:(UIFont *)textFont andMaxWidth:(CGFloat)maxWidth;


// 去掉首尾空格
+ (NSString *)handleCommentStrEnumerationWithStr:(NSString *)string;
@end


