//
//  UmengLoginShare.m
//  UmengLoginAndShare
//
//  Created by Liumingfei on 16/9/29.
//  Copyright © 2016年 LiuMingFei. All rights reserved.
//

#import "UmengLoginShare.h"

@implementation UmengLoginShare

+ (instancetype)defaultManager {
    static UmengLoginShare *UmengUserInfo = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!UmengUserInfo) {
            UmengUserInfo = [[UmengLoginShare alloc] init];
        }
    });
    return UmengUserInfo;
}

#pragma mark - 登录授权
+ (void)UmengLoginWithType:(UmengLoginType)loginType currentViewController:(id)currentViewController userOpenId:(void(^)(NSString *openId))openId {

        [[UMSocialManager defaultManager] authWithPlatform:(UMSocialPlatformType)loginType currentViewController:currentViewController completion:^(id result, NSError *error) {
        
        if (result) {
            
            UMSocialAuthResponse *authresponse = result;
            
//            NSString *message = [NSString stringWithFormat:@"result: %d\n uid: %@\n accessToken: %@\n",(int)error.code,authresponse.uid,authresponse.accessToken];
//            NSLog(@"%@",message);
            
            openId(authresponse.openid);
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }];
    
}

#pragma mark - 获取用户信息
+ (void)UmengGetUserInfoWithPlatformType:(UmengLoginType)loginType currentViewController:(id)currentViewController userInfo:(void(^)(UmengLoginShare *userIn))info {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:(UMSocialPlatformType)loginType currentViewController:currentViewController completion:^(id result, NSError *error) {
        
        if (result) {
            
            UMSocialUserInfoResponse *userinfo = result;
            NSDictionary *infoDic = userinfo.originalResponse;
            
            UmengLoginShare *UmengUserInfo = [UmengLoginShare defaultManager];
            
            UmengUserInfo.nickName = infoDic[@"nickname"];
            UmengUserInfo.city = infoDic[@"city"];
            UmengUserInfo.province = infoDic[@"province"];
            
            if (loginType == UmengLoginType_WXSession) {
                UmengUserInfo.iconUrl = infoDic[@"headimgurl"];
                if ([[infoDic[@"sex"] stringValue] isEqualToString:@"0"]) {
                    UmengUserInfo.gender = @"女";
                } else if ([[infoDic[@"sex"] stringValue] isEqualToString:@"1"]) {
                    UmengUserInfo.gender = @"男";
                }
                UmengUserInfo.country = infoDic[@"country"];
                UmengUserInfo.openId = infoDic[@"openid"];
                UmengUserInfo.unionId = infoDic[@"unionid"];
            } else if (loginType == UmengLoginType_QQ) {
                UmengUserInfo.iconUrl = infoDic[@"figureurl_qq_2"];
                UmengUserInfo.gender = infoDic[@"gender"];
                UmengUserInfo.openId = [infoDic[@"figureurl_qq_2"] componentsSeparatedByString:@"/"][5];
                UmengUserInfo.unionId = UmengUserInfo.openId;
            }

            info(UmengUserInfo);
            
        } else {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"登录失败"
                                                            message:nil
                                                           delegate:nil
                                                  cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                                  otherButtonTitles:nil];
            [alert show];
        }
    }];
}

#pragma mark - 分享
+ (void)UmengShareDataWithType:(UmengShareType)shareType dataType:(ShareDataType)dataType title:(NSString *)title url:(NSString *)url content:(NSString *)content image:(id)image currentViewController:(id)currentViewController {

    //判断是否安装
    if (![[UMSocialManager defaultManager] isInstall:(UMSocialPlatformType)shareType]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                        message:@"未安装该应用"
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    switch (dataType) {
        case UmengShareDataType_url:
        {
            //创建网页分享对象
            UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:content thumImage:image];
            [shareObject setWebpageUrl:url];
            messageObject.shareObject = shareObject;
        }
            break;
        case UmengShareDataType_image:
        {
            //创建图片对象
            UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:content thumImage:image];
            [shareObject setShareImage:image];
            messageObject.shareObject = shareObject;
            
        }
            break;
        case UmengShareDataType_video:
        {
            //创建视频对象
            UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:content thumImage:image];
            [shareObject setVideoUrl:url];
            messageObject.shareObject = shareObject;
        }
            
            break;
        case UmengShareDataType_music:
        {
            //创建音乐对象
            UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:content thumImage:image];
            [shareObject setMusicUrl:url];
            messageObject.shareObject = shareObject;
        }
            
            break;
        default:
            break;
    }

    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:(UMSocialPlatformType)shareType messageObject:messageObject currentViewController:currentViewController completion:^(id data, NSError *error) {
        
        NSString *message = nil;
        
        if (!error) {
            message = [NSString stringWithFormat:@"分享成功"];
        } else {
//            if (error) {
//                message = [NSString stringWithFormat:@"失败原因Code: %d\n",(int)error.code];
//            } else {
//                message = [NSString stringWithFormat:@"分享失败"];
//            }
            message = [NSString stringWithFormat:@"分享失败"];
        }
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

@end







