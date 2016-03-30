//
//  HttpTool.m
//  PrintPhoto
//
//  Created by jangbuk on 15/8/12.
//  Copyright (c) 2015年 jangbuk. All rights reserved.
//

#import "HttpTool.h"

@implementation HttpTool

+(void)Get:(NSString *)urlName RequestSerializerType:(RequestSerializerType)type Params:(NSDictionary *)params UseCache:(BOOL)useCache HttpHeaderToken:(NSString*)httpHeaderToken Success:(void (^)(id json))success Failure:(void (^)(NSString *error))failure;
{
    NSString *cache_key=[Common GetMD5ByUrlName:urlName Dictionary:params];
    
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];

    // 1.获得请求管理者
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    
    //设置请求入参的序列化类型
    if (type==RequestSerializerTypeHTTP) {
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if(type==RequestSerializerTypeJSON)
    {
        mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    }
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [mgr.requestSerializer setValue:httpHeaderToken forHTTPHeaderField:HttpHeaderFieldName];
    
    // 2.发送GET请求
    [mgr setSecurityPolicy:policy];
    mgr.requestSerializer = [AFJSONRequestSerializer serializer];
    
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    [mgr GET:urlName parameters:params
     success:^(AFHTTPRequestOperation *operation, id responseObj) {
         if (useCache) {//判断是否开启缓存
             //判断有无缓存，无的话，获取的数据写入本地
             if (![[EGOCache globalCache] hasCacheForKey:cache_key]) {
                 [[EGOCache globalCache ] setObject:responseObj forKey:cache_key];
             }
         }
         
         NSLog(@"GET请求返回数据%@",responseObj);
         if ([Common IsRequestSuccess:responseObj]) {
             success(responseObj);
         }else
             failure([Common GetResponseMSG:responseObj]);
     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         //如果开启了缓存
         if (useCache) {
             //无缓存 直接打印错误消息
             if (![[EGOCache globalCache] hasCacheForKey:cache_key]) {
                 failure([NSString stringWithFormat:@"%@",error]);
             }else
             {
                 //有缓存 从success中返回
                 success([[EGOCache globalCache] objectForKey:cache_key]);
             }
             
         }else //没有开启缓存
         {
             failure([NSString stringWithFormat:@"%@",error]);
         }
     }];
}

+(void)Post:(NSString *)urlName RequestSerializerType:(RequestSerializerType)type Params:(NSDictionary *)params UseCache:(BOOL)useCache HttpHeaderToken:(NSString*)httpHeaderToken Success:(void (^)(id json))success Failure:(void (^)(NSString *error))failure;
{
    NSString *cache_key=[Common GetMD5ByUrlName:urlName Dictionary:params];
    
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:YES];
    
    // 1.获得请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    [mgr setSecurityPolicy:policy];
    
    //设置请求入参的序列化类型
    if (type==RequestSerializerTypeHTTP) {
        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    }else if(type==RequestSerializerTypeJSON)
    {
        mgr.requestSerializer=[AFJSONRequestSerializer serializer];
    }
    mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //http头验证
    [mgr.requestSerializer setValue:httpHeaderToken forHTTPHeaderField:HttpHeaderFieldName];
    
    // 2.发送POST请求
    [mgr POST:[NSString stringWithFormat:@"%@%@",CommonServerURL,urlName] parameters:params
   
      success:^(AFHTTPRequestOperation *operation, id responseObj) {
          
          if (useCache) {//判断是否开启缓存
              //判断有无缓存，无的话，获取的数据写入本地
              if (![[EGOCache globalCache] hasCacheForKey:cache_key]) {
                  [[EGOCache globalCache ] setObject:responseObj forKey:cache_key];
              }
          }
          
          NSLog(@"POST请求返回数据%@",responseObj);
          if ([Common IsRequestSuccess:responseObj]) {
              success(responseObj);
          }else
              failure([Common GetResponseMSG:responseObj]);
          
      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
          //如果开启了缓存
          if (useCache) {
              //无缓存 直接打印错误消息
              if (![[EGOCache globalCache] hasCacheForKey:cache_key]) {
                  failure([NSString stringWithFormat:@"%@",error]);
              }else
              {
                  //有缓存 从success中返回
                  success([[EGOCache globalCache] objectForKey:cache_key]);
              }
              
          }else //没有开启缓存
          {
              failure([NSString stringWithFormat:@"%@",error]);
          }
          
      }];
}

/**
 *  上传文件请求
 */
+ (void)Upload:(NSString *)url Params:(NSDictionary *)params DataSource:(FormData *)dataSource Success:(void (^)(id json))success Failure:(void (^)(NSError * error))failure Progress:(void(^)(float percent))percent
{

    // 1.获得请求管理者
    AFHTTPRequestOperationManager * mgr = [AFHTTPRequestOperationManager manager];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];

    
    
    AFHTTPRequestOperation *operation= [mgr POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:dataSource.fileData name:dataSource.name fileName:dataSource.fileName mimeType:dataSource.fileType];
        
        //NSURL *filePath =[[NSBundle mainBundle] URLForResource:@"abc" withExtension:@"png"];
        
        
        //[formData appendPartWithFileURL:filePath name:@"file" fileName:[NSString stringWithFormat:@"%@.png",@"abc"] mimeType:@"image/png" error:nil];
        
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        if (success) {
            
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            
            success([jsonString mj_JSONObject]);
            
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
    [operation setUploadProgressBlock:^(NSUInteger __unused bytesWritten,
                                        long long totalBytesWritten,
                                        long long totalBytesExpectedToWrite) {

        if (percent) {
            
            float f_precent=(float)totalBytesWritten/totalBytesExpectedToWrite;
            
            percent( f_precent);
            
        }
    }];
    
    // 5. Begin!
    [operation start];
    
}

+(void)DownloadFileWithOption:(NSDictionary *)paramDic
                withInferface:(NSString*)requestURL
                    savedPath:(NSString*)savedPath
              downloadSuccess:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
              downloadFailure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
                     progress:(void (^)(float progress))progress

{
    
    //沙盒路径    //NSString *savedPath = [NSHomeDirectory() stringByAppendingString:@"/Documents/xxx.zip"];
    AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
    NSMutableURLRequest *request =[serializer requestWithMethod:@"POST" URLString:requestURL parameters:paramDic error:nil];
    
    //以下是手动创建request方法 AFQueryStringFromParametersWithEncoding有时候会保存
    //   NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestURL]];
    //   NSMutableURLRequest *request =[[[AFHTTPRequestOperationManager manager]requestSerializer]requestWithMethod:@"POST" URLString:requestURL parameters:paramaterDic error:nil];
    //
    //    NSString *charset = (__bridge NSString *)CFStringConvertEncodingToIANACharSetName(CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    //
    //    [request setValue:[NSString stringWithFormat:@"application/x-www-form-urlencoded; charset=%@", charset] forHTTPHeaderField:@"Content-Type"];
    //    [request setHTTPMethod:@"POST"];
    //
    //    [request setHTTPBody:[AFQueryStringFromParametersWithEncoding(paramaterDic, NSASCIIStringEncoding) dataUsingEncoding:NSUTF8StringEncoding]];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    [operation setOutputStream:[NSOutputStream outputStreamToFileAtPath:savedPath append:NO]];
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead, long long totalBytesRead, long long totalBytesExpectedToRead) {
        float p = (float)totalBytesRead / totalBytesExpectedToRead;
        progress(p);
        NSLog(@"download：%f", (float)totalBytesRead / totalBytesExpectedToRead);
        
    }];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation,responseObject);
        NSLog(@"下载成功");
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        success(operation,error);
        
        NSLog(@"下载失败");
        
    }];
    
    [operation start];
    
}


@end
/**
 *  用来封装文件数据的模型
 */

@implementation FormData
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fileType=@"";//文件类型
        self.name=@"file";//文件接收对应键
        self.fileName=@"";//文件名
    }
    return self;
}

@end