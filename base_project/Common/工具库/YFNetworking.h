//
//  YFNetworking.h
//
//
//  Created by jangbuk on 15/11/15.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#pragma mark--网络请求打印日志
// 只在开发阶段会打印输出日志
#ifdef DEBUG
#define YFAppLog(s, ... ) NSLog( @"[%@ in line %d] ===============>%@", [[NSString stringWithUTF8String:__FILE__] lastPathComponent], __LINE__, [NSString stringWithFormat:(s), ##__VA_ARGS__] )
#else
#define YFAppLog(s, ... )
#endif

/*!
 *  @author jangbuk, 16-01-08 14:01:26
 *
 *  下载进度
 *
 *  @param bytesRead                 已下载的大小
 *  @param totalBytesRead            文件总大小
 *  @param totalBytesExpectedToRead 还有多少需要下载
 */
typedef void (^YFDownloadProgress)(int64_t bytesRead,
                                    int64_t totalBytesRead);

typedef YFDownloadProgress YFGetProgress;
typedef YFDownloadProgress YFPostProgress;

/*!
 *  @author jangbuk, 16-01-08 14:01:26
 *
 *  上传进度
 *
 *  @param bytesWritten              已上传的大小
 *  @param totalBytesWritten         总上传大小
 */
typedef void (^YFUploadProgress)(int64_t bytesWritten,
                                  int64_t totalBytesWritten);

typedef NS_ENUM(NSUInteger, YFResponseType) {
  YFResponseTypeJSON = 1, // 默认
  YFResponseTypeXML  = 2, // XML
  // 特殊情况下，一转换服务器就无法识别的，默认会尝试转换成JSON，若失败则需要自己去转换
  kYFResponseTypeData = 3
};

typedef NS_ENUM(NSUInteger, YFRequestType) {
  YFRequestTypeJSON = 1, // 默认
  YFRequestTypePlainText  = 2 // 普通text/html
};

@class NSURLSessionTask;

// 请勿直接使用NSURLSessionDataTask,以减少对第三方的依赖
// 所有接口返回的类型都是基类NSURLSessionTask，若要接收返回值
// 且处理，请转换成对应的子类类型
typedef NSURLSessionTask YFURLSessionTask;
typedef void(^YFResponseSuccess)(id response);
typedef void(^YFResponseFail)(NSError *error);

/*!
 *  @author jangbuk, 15-11-15 13:11:31
 *
 *  基于AFNetworking的网络层封装类.
 *
 *  @note 这里只提供公共api
 */


@interface YFNetworking : NSObject

#pragma mark--设置开启或关闭接口打印信息
/*!
 *  @author jangbuk, 15-11-15 14:11:40
 *
 *  开启或关闭接口打印信息
 *
 *  @param isDebug 开发期，最好打开，默认是NO
 */
+ (void)enableInterfaceDebug:(BOOL)isDebug;

#pragma mark--设置网络接口的基础地址
/*!
 *  @author jangbuk, 15-11-15 13:11:45
 *
 *  用于指定网络请求接口的基础url，如：
 *  http://s3.xtox.net或者http://192.168.1.1
 *  通常在AppDelegate中启动时就设置一次就可以了。如果接口有来源
 *  于多个服务器，可以调用更新
 *
 *  @param baseUrl 网络接口的基础url
 */

+ (void)updateBaseUrl:(NSString *)baseUrl;
+ (NSString *)baseUrl;


#pragma mark--设置网络请求缓存机制
/**
 *	@author jangbuk
 *
 *	默认只缓存GET请求的数据，对于POST请求是不缓存的。如果要缓存POST获取的数据，需要手动调用设置
 *  对JSON类型数据有效，对于PLIST、XML暂不考虑！
 *
 *	@param isCacheGet			默认为YES
 *	@param shouldCachePost	默认为NO
 */ 
+ (void)cacheGetRequest:(BOOL)isCacheGet shoulCachePost:(BOOL)shouldCachePost;

/**
 *	@author jangbuk
 *
 *	获取缓存总大小/bytes
 *
 *	@return 缓存大小
 */
+ (unsigned long long)totalCacheSize;

/**
 *	@author jangbuk
 *
 *	清除缓存
 */

+ (void)clearCaches;



#pragma mark--设置网络请求、响应、头地址

/*!
 *  @author jangbuk, 15-12-25 15:12:45
 *
 *  配置请求格式，默认为JSON。如果要求传XML或者PLIST，请在全局配置一下
 *
 *  @param requestType 请求格式，默认为JSON
 *  @param responseType 响应格式，默认为JSON
 *  @param shouldAutoEncode YES or NO,默认为NO，是否自动encode url
 *  @param shouldCallbackOnCancelRequest 当取消请求时，是否要回调，默认为YES
 */
+ (void)configRequestType:(YFRequestType)requestType
             responseType:(YFResponseType)responseType
      shouldAutoEncodeUrl:(BOOL)shouldAutoEncode
  callbackOnCancelRequest:(BOOL)shouldCallbackOnCancelRequest;

/*!
 *  @author jangbuk, 15-11-16 13:11:41
 *
 *  配置公共的请求头，只调用一次即可，通常放在应用启动的时候配置就可以了
 *
 *  @param httpHeaders 只需要将与服务器商定的固定参数设置即可
 */
+ (void)configCommonHttpHeaders:(NSDictionary *)httpHeaders;

/**
 *	@author jangbuk
 *
 *	取消所有请求
 */
+ (void)cancelAllRequest;
/**
 *	@author jangbuk
 *
 *	取消某个请求。如果是要取消某个请求，最好是引用接口所返回来的YFURLSessionTask对象，
 *  然后调用对象的cancel方法。如果不想引用对象，这里额外提供了一种方法来实现取消某个请求
 *
 *	@param url				URL，可以是绝对URL，也可以是path（也就是不包括baseurl）
 */
+ (void)cancelRequestWithURL:(NSString *)url;

/*!
 *  @author jangbuk, 15-11-15 13:11:50
 *
 *  GET请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList
 *  @param refreshCache 是否刷新缓存。由于请求成功也可能没有数据，对于业务失败，只能通过人为手动判断
 *  @param params  接口中所需要的拼接参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (YFURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                          success:(YFResponseSuccess)success
                             fail:(YFResponseFail)fail;
// 多一个params参数
+ (YFURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                          success:(YFResponseSuccess)success
                             fail:(YFResponseFail)fail;
// 多一个带进度回调
+ (YFURLSessionTask *)getWithUrl:(NSString *)url
                     refreshCache:(BOOL)refreshCache
                           params:(NSDictionary *)params
                         progress:(YFGetProgress)progress
                          success:(YFResponseSuccess)success
                             fail:(YFResponseFail)fail;

/*!
 *  @author jangbuk, 15-11-15 13:11:50
 *
 *  POST请求接口，若不指定baseurl，可传完整的url
 *
 *  @param url     接口路径，如/path/getArticleList
 *  @param params  接口中所需的参数，如@{"categoryid" : @(12)}
 *  @param success 接口成功请求到数据的回调
 *  @param fail    接口请求数据失败的回调
 *
 *  @return 返回的对象中有可取消请求的API
 */
+ (YFURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                           success:(YFResponseSuccess)success
                              fail:(YFResponseFail)fail;
+ (YFURLSessionTask *)postWithUrl:(NSString *)url
                      refreshCache:(BOOL)refreshCache
                            params:(NSDictionary *)params
                          progress:(YFPostProgress)progress
                           success:(YFResponseSuccess)success
                              fail:(YFResponseFail)fail;
/**
 *	@author jangbuk, 16-01-31 00:01:40
 *
 *	图片上传接口，若不指定baseurl，可传完整的url
 *
 *	@param image			图片对象
 *	@param url				上传图片的接口路径，如/path/images/
 *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
 *	@param name				与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
 *	@param mimeType		默认为image/jpeg
 *	@param parameters	参数
 *	@param progress		上传进度
 *	@param success		上传成功回调
 *	@param fail				上传失败回调
 *
 *	@return
 */
+ (YFURLSessionTask *)uploadWithImage:(UIImage *)image
                                   url:(NSString *)url
                              filename:(NSString *)filename
                                  name:(NSString *)name
                              mimeType:(NSString *)mimeType
                            parameters:(NSDictionary *)parameters
                              progress:(YFUploadProgress)progress
                               success:(YFResponseSuccess)success
                                  fail:(YFResponseFail)fail;

/**
 *	@author jangbuk, 16-01-31 00:01:59
 *
 *	上传文件操作
 *
 *	@param url						上传路径
 *	@param uploadingFile	待上传文件的路径
 *	@param progress			上传进度
 *	@param success				上传成功回调
 *	@param fail					上传失败回调
 *
 *	@return
 */
+ (YFURLSessionTask *)uploadFileWithUrl:(NSString *)url
                           uploadingFile:(NSString *)uploadingFile
                                progress:(YFUploadProgress)progress
                                 success:(YFResponseSuccess)success
                                    fail:(YFResponseFail)fail;


/*!
 *  @author jangbuk, 16-01-08 15:01:11
 *
 *  下载文件
 *
 *  @param url           下载URL
 *  @param saveToPath    下载到哪个路径下
 *  @param progressBlock 下载进度
 *  @param success       下载成功后的回调
 *  @param failure       下载失败后的回调
 */
+ (YFURLSessionTask *)downloadWithUrl:(NSString *)url
                            saveToPath:(NSString *)saveToPath
                              progress:(YFDownloadProgress)progressBlock
                               success:(YFResponseSuccess)success
                               failure:(YFResponseFail)failure;

@end
