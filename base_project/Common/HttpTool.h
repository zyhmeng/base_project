//
//  HttpTool.h
//  PrintPhoto
//
//  Created by jangbuk on 15/8/12.
//  Copyright (c) 2015年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>

//用来封装 上传文件 的数据模型
@interface FormData : NSObject
@property(nonatomic,strong)NSData * fileData;//文件数据
@property(nonatomic,copy)NSString * fileName;//文件名.jpg
@property(nonatomic,copy)NSString * name;//参数名
@property(nonatomic,copy)NSString * fileType;//文件类型
@end

//网络请求时入参的两种序列化类型
typedef enum{
    RequestSerializerType_JSON,//json
    RequestSerializerType_HTTP //http
}Enum_RequestSerializerType;

@interface HttpTool : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url      请求路径
 *  @param params   请求参数
 *  @param useCache 是否需要缓存
 *  @param httpHeaderToken http头验证
 *  @param success  请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure  请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+(void)Get:(NSString *)urlName RequestSerializerType:(Enum_RequestSerializerType)type Params:(NSDictionary *)params UseCache:(BOOL)useCache HttpHeaderToken:(NSString*)httpHeaderToken Success:(void (^)(id json))success Failure:(void (^)(NSString *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param urlName  请求路径
 *  @param params   请求参数
 *  @param useCache 是否需要缓存 缓存规则：入参字符串对应的键
 *  @param httpHeaderToken http头验证
 *  @param success  请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure  请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */


/**
 *  <#Description#>
 *
 *  @param urlName         <#urlName description#>
 *  @param type            <#type description#>
 *  @param params          <#params description#>
 *  @param useCache        <#useCache description#>
 *  @param httpHeaderToken <#httpHeaderToken description#>
 *  @param success         <#success description#>
 *  @param failure         <#failure description#>
 */

+(void)Post:(NSString *)urlName RequestSerializerType:(Enum_RequestSerializerType)type Params:(NSDictionary *)params UseCache:(BOOL)useCache HttpHeaderToken:(NSString*)httpHeaderToken Success:(void (^)(id json))success Failure:(void (^)(NSString *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param formData 文件参数 需传入fileData fileName(xxx.jpg)
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 *  @param percent 请求中的回调（上传完成百分比）
 */

+ (void)Upload:(NSString *)url Params:(NSDictionary *)params DataSource:(FormData *)dataSource Success:(void (^)(id json))success Failure:(void (^)(NSError *error))failure Progress:(void(^)(float percent))percent;

@end


