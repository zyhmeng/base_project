//
//  PayAction.m
//  base_project
//
//  Created by jangbuk on 15/12/3.
//  Copyright © 2015年 jangbuk. All rights reserved.
//

#import "PayAction.h"

#pragma mark--支付宝依赖
#import <AlipaySDK/AlipaySDK.h>
#import "AliOrder.h"
#import "DataSigner.h"
#import "APAuthV2Info.h"
#pragma mark--微信依赖
#import "WXApi.h"
#import "PayRequsestHandler.h"

@implementation PayAction

+(void)AliPayActionByTradeNo:(NSString*)tradeNo ProductDesc:(NSString *)productDesc ProductName:(NSString *)productName Amount:(NSString *)amount success:(void(^)(NSString *success))success
       failure:(void(^)(NSString *error))failure

{
    //实例化支付提交的数据模型
    
    AliOrder *order=[[AliOrder alloc] initWithAlipayTradeNo:tradeNo productDescription:productDesc productName:productName amount:amount];
    
    /*
     *商户的唯一的parnter和seller。
     *签约后，支付宝会为每个商户分配一个唯一的 parnter 和 seller。
     */
    
    NSString *privateKey =AliPay_PrivateKey;
    
    //partner和seller获取失败,提示
    if([privateKey length] == 0)
    {
        NSString *error = @"privateKey的值为空";
        failure(error);
        return;
    }
    
    //应用注册scheme,在AlixPayDemo-Info.plist定义URL types
    NSString *appScheme = AliPay_AppScheme;
    
    //将商品信息拼接成字符串
    NSString *orderSpec = [order description];
    NSLog(@"orderSpec = %@",orderSpec);
    
    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
    id<DataSigner> signer = CreateRSADataSigner(privateKey);
    NSString *signedString = [signer signString:orderSpec];
    
    //将签名成功字符串格式化为订单字符串,请严格按照该格式
    
    NSString *orderString = nil;
    if (signedString != nil) {
        orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                       orderSpec, signedString, @"RSA"];
        
        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
            
            NSLog(@"reslut = %@",resultDic);
            
            NSLog(@"%@",appScheme);
            
            NSNumber *resultStatus = [resultDic objectForKey:@"resultStatus"];
            
            if (resultStatus.intValue == 9000) {
                NSString *successStr = [resultDic objectForKey:@"result"];
                
                NSLog(@"%@",successStr);
                success(successStr);
                
            }else
            {
                failure(@"支付失败");
            }
            
        }];
    }
    
}

//微信支付
/*
 *微信支付step1  选择商品下单
 *       step2  请求生成支付订单，返回信息（prepay_id,sign等）
 *       step3  调用统一下单API，返回预付单信息（prepay_id）
 *       step4  想获得prepayid需要由预支付信息生成带参数的签名包
 */



//微信支付step1  选择商品下单
+(void)WeChatPayActionByTradeNo:(NSString *)tradeNo OrderName:(NSString *)orderName andPrice:(NSString *)price
{
     [WXApi registerApp:WeChat_App_ID withDescription:@"weChatDemo"];
    
    
    if ([WXApi isWXAppInstalled]==NO) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"未安装微信" message:@"请先安装微信客户端" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return;
    }
    
    
    
    
    //1. 创建支付签名对象
    PayRequsestHandler *req = [[PayRequsestHandler alloc] init];
    //  初始化支付签名对象
    [req init:WeChat_App_ID mch_id:WeChat_MCH_ID];
    //  设置密钥
    [req setKey:WeChat_Partner_ID];
    
    
    //2. step2 请求生成支付订单，返回信息（prepay_id,sign等）
    NSMutableDictionary *dict = [req WXPayByTrade_no:tradeNo order_name:orderName andPrice:price];
    
    if(dict == nil){
        //错误提示
        NSString *debug = [req getDebugifo];
        
        NSLog(@"%@\n\n",debug);
        
    }else{
        NSLog(@"%@\n\n",[req getDebugifo]);
        
        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
        
        //调起微信支付
        PayReq* req = [[PayReq alloc] init];
        req.openID  = [dict objectForKey:@"appid"];
        req.partnerId = [dict objectForKey:@"partnerid"];
        req.prepayId = [dict objectForKey:@"prepayid"];
        req.nonceStr = [dict objectForKey:@"noncestr"];
        req.timeStamp = stamp.intValue;
        req.package = [dict objectForKey:@"package"];
        req.sign = [dict objectForKey:@"sign"];
        
        [WXApi sendReq:req]; //发起支付
    }
    
}

@end
