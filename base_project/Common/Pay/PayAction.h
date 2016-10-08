//
//  PayAction.h
//  base_project
//
//  Created by jangbuk on 15/12/3.
//  Copyright © 2015年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayAction : NSObject

/**
 *  支付宝支付静态方法
 *
 *  @param tradeNo     订单流水号
 *  @param productDesc 商品描述
 *  @param productName 商品名
 *  @param amount      商品价格
 *  @param success     回调 支付成功操作
 *  @param failure     回调 支付失败操作
 */

+(void)AliPayActionByTradeNo:(NSString*)tradeNo ProductDesc:(NSString *)productDesc ProductName:(NSString *)productName Amount:(NSString *)amount success:(void(^)(NSString *success))success
                     failure:(void(^)(NSString *error))failure;

/**
 *  微信支付静态方法
 *
 *  @param tradeNo     商户订单号
 *  @param orderName   订单标题，展示给用户
 *  @param price       商品价格
 */ 
+(void)WeChatPayActionByTradeNo:(NSString *)tradeNo OrderName:(NSString *)orderName andPrice:(NSString *)price;
@end
