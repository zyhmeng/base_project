//
//  WebViewModel.m
//  WebView
//
//  Created by zhuangshuai on 16/9/29.
//  Copyright © 2016年 zhuangshuai. All rights reserved.
//

#import "WebViewModel.h"


@implementation WebViewModel

//拼接html
+ (NSString *)showInWebViewDataString:(NSString *)string
{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    //加载样式
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"common.css" withExtension:nil]];
    
    [html appendString:@"</head>"];
    
    [html appendString:@"<body style=\"background:#f6f6f6\">"];
    [html appendString:[self webViewDataString:string]];
    [html appendString:@"</body>"];
    
    [html appendString:@"</html>"];
    
    return [html copy];
}

+ (NSString *)webViewDataString:(NSString *)string
{
    NSMutableString *body = [NSMutableString string];
    
    [body appendFormat:@"<div class=\"title\">%@</div>",@"富文本处理"];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *timeStr = [formatter stringFromDate:[NSDate date]];
    
    [body appendFormat:@"<div class=\"time\">富文本处理 %@</div>",timeStr];
    [body appendFormat:@"<div class=\"content\">%@</div>",string];

    return body;
}


@end




