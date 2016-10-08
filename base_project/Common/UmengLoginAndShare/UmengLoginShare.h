//
//  UmengLoginShare.h
//  UmengLoginAndShare
//
//  Created by Liumingfei on 16/9/29.
//  Copyright © 2016年 LiuMingFei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>

//登录平台类型
typedef NS_ENUM(NSInteger,UmengLoginType)
{
    UmengLoginType_Sina = 0,         //新浪
    UmengLoginType_WXSession = 1,    //微信
    UmengLoginType_QQ = 4,           //QQ
};

//分享平台类型
typedef NS_ENUM(NSInteger,UmengShareType)
{
    UmengShareType_Sina = 0,        //新浪
    UmengShareType_WXSession,       //微信聊天页面
    UmengShareType_WXTimeLine,      //微信朋友圈
    UmengShareType_WXFavorite,      //微信收藏
    UmengShareType_QQ,              //QQ聊天页面
    UmengShareType_Qzone,           //QQ空间
};

//分享内容类型
typedef NS_ENUM(NSInteger,ShareDataType)
{
    UmengShareDataType_url = 0,   //web
    UmengShareDataType_image,     //图片
    UmengShareDataType_video,     //视频
    UmengShareDataType_music,     //音乐
};

@interface UmengLoginShare : NSObject

@property (nonatomic, strong) NSString *nickName;   //昵称
@property (nonatomic, strong) NSString *iconUrl;    //头像
@property (nonatomic, strong) NSString *gender;     //性别
@property (nonatomic, strong) NSString *city;       //城市
@property (nonatomic, strong) NSString *province;   //省份
@property (nonatomic, strong) NSString *country;    //国家（微信）
@property (nonatomic, strong) NSString *openId;     //openId
@property (nonatomic, strong) NSString *unionId;    //unionId（微信）

+(instancetype)defaultManager;

/**
 *  登录授权
 *
 *  用于获取第三方平台的openId
 *
 *  @param loginType 登录平台类型
 *  @param currentViewController 微信平台需要传入viewcontroller的平台，其他不需要的平台可以传入nil
 *  @param openId   回调（返回openId）
 */
+ (void)UmengLoginWithType:(UmengLoginType)loginType currentViewController:(id)currentViewController userOpenId:(void(^)(NSString *openId))openId;

/**
 *  获取用户信息
 *
 *  用于获取用户在第三方平台的 昵称，头像，性别
 *  （获取微信用户信息时应先调用登录授权接口，否则第一次登录会弹出两次授权页面，且在授权有效期内，后续登录时，不会再跳转授权页面，导致微信客户端更换用户，此处无法更新至最新用户。）
 *  （获取QQ用户信息时，不用调用登录授权接口，否则会弹出两次授权页面）
 *
 *  @param loginType 登录平台类型
 *  @param currentViewController 微信平台需要传入viewcontroller的平台，其他不需要的平台可以传入nil
 *  @param info   回调（返回用户信息）
 */
+ (void)UmengGetUserInfoWithPlatformType:(UmengLoginType)loginType currentViewController:(id)currentViewController userInfo:(void(^)(UmengLoginShare *userIn))info;

/**
 *  分享
 *
 *  @param shareType 分享平台类型
 *  @param dataType  分享内容的类型（web，图片，视频，音乐）
 *  @param title     分享题目
 *  @param url       分享url（音乐，视频传入相应url）
 *  @param content   分享内容
 *  @param image     分享缩略图 （大小一般不要超过24k，图片过大分享后可能无法显示）
 *  @param currentViewController 微信平台需要传入viewcontroller的平台，其他不需要的平台可以传入nil
 */
+ (void)UmengShareDataWithType:(UmengShareType)shareType dataType:(ShareDataType)dataType title:(NSString *)title url:(NSString *)url content:(NSString *)content image:(id)image currentViewController:(id)currentViewController;


@end







