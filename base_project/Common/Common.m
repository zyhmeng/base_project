
//
//  Common.m
//  IOSTrain
//
//  Created by jangbuk on 15/8/13.
//  Copyright (c) 2015年 jangbuk. All rights reserved.
//

#import "Common.h"

@implementation Common

+ (id)GetRequestResultFromResponse:(id)response
{
    return [response objectForKey:@"result"];    
}

+ (NSString *)GetErrorStrFromResponse:(id)response
{
    return [response objectForKey:@"retDese"];
}

+(BOOL)IsRequestSuccess:(id)response_object
{
    if ([[[response_object objectForKey:@"retCode"] stringValue]isEqualToString:@"0"]==YES) {
        return YES;
    }else if ([[[response_object objectForKey:@"retCode"] stringValue]isEqualToString:@"0"]==NO)
    {
        return NO;
    }else
        return NO;
}

+(NSString *)GetResponseMSG:(id)response_object
{
    return [response_object objectForKey:@"retDese"];
}

+(NSNumber *)GetResponseCode:(id)response_object
{
    return [response_object objectForKey:@"retCode"];
}

+(id)GetResponseData:(id)response_object ByKey:(NSString *)key
{
    return [response_object objectForKey:key];
}

+(NSString*)GetMD5ByUrlName:(NSString *)url Dictionary:(NSDictionary *)dic
{
    NSString *md5_str=@"";

    md5_str = [Common md5:[NSString stringWithFormat:@"%@%@",url,[dic JSONString]]];
    
    NSLog(@"本次请求的数据的md5%@",md5_str);
    return md5_str;
}

+(NSString *) md5: (NSString *) inPutText
{
    const char *cStr = [inPutText UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStr, strlen(cStr), result);
    
    return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1], result[2], result[3],
             result[4], result[5], result[6], result[7],
             result[8], result[9], result[10], result[11],
             result[12], result[13], result[14], result[15]
             ] lowercaseString];
}

+(BOOL)CheckIsTelNum:(NSString *)str
{
    if ([str length] == 0) {
        
        return NO;
    }
    
    //NSString *regex = @"^((13[0-9])|(147)|(170)|(15[^4,\\D])|(18[0,2,5-9]))\\d{8}$";
    NSString *regex = @"^(1)\\d{10}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:str];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}


+(BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(BOOL)CheckIsIncludeNumAndWord:(NSString *)str
{
    
    NSString *testString = str;
    
    int alength = [testString length];
    
    BOOL b_return=YES;
    for (int i = 0; i<alength; i++) {
        char commitChar = [testString characterAtIndex:i];
        NSString *temp = [testString substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){
            NSLog(@"字符串中含有中文");
            b_return=NO;
            return b_return;
        }else if((commitChar>64)&&(commitChar<91)){
            NSLog(@"字符串中含有大写英文字母");
        }else if((commitChar>96)&&(commitChar<123)){
            NSLog(@"字符串中含有小写英文字母");
        }else if((commitChar>47)&&(commitChar<58)){
            NSLog(@"字符串中含有数字");
        }else{
            NSLog(@"字符串中含有非法字符");
            b_return=NO;
            return b_return;
        }
    }
    
    return b_return;
    
}

+ (BOOL)stringIsEmpty:(NSString *)string
{
    return (string==nil || [string isEqualToString:@""]);
}

+(void)SetNav:(UINavigationBar *)bar
{
    bar.barTintColor=NAV_COLOR;
    bar.alpha=1;
    
    [bar setTranslucent:NO];
    
    [bar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],
                                  NSFontAttributeName:[UIFont systemFontOfSize:18]
                                  }];
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

+(void)DrowLineAtImageView:(UIImageView *)image_view StartPoint:(CGPoint )line_start_pt EndPoint:(CGPoint )line_end_pt Color:(UIColor *)line_color LineWidth:(float)line_width
{
    
    UIGraphicsBeginImageContext(image_view.frame.size);
    [image_view.image drawInRect:CGRectMake(0, 0, image_view.frame.size.width, image_view.frame.size.height)];
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), line_width);  //线宽
    CGContextSetAllowsAntialiasing(UIGraphicsGetCurrentContext(), YES);
    
    
    const CGFloat *components = CGColorGetComponents(line_color.CGColor);
    NSLog(@"Red: %f", components[0]);
    NSLog(@"Green: %f", components[1]);
    NSLog(@"Blue: %f", components[2]);
    
    
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), components[0], components[1], components[2], 1.0);  //颜色
    
    CGContextBeginPath(UIGraphicsGetCurrentContext());
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), line_start_pt.x, line_start_pt.y);  //起点坐标
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), line_end_pt.x, line_end_pt.y);   //终点坐标
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    image_view.image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
}


+(NSDate *)dateFromString:(NSString *)dateString{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    //[dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"GMT+0800"]];
    
    NSDate *destDate= [dateFormatter dateFromString:dateString];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    
    NSInteger interval = [zone secondsFromGMTForDate: destDate];
    
    NSDate *localeDate = [destDate  dateByAddingTimeInterval: interval];
    
    return localeDate;
    
}

+(BOOL)myString:(NSString *)string ContainsString:(NSString*)other {
    NSRange range = [string rangeOfString:other];
    return range.length != 0;
}

+(long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//遍历文件夹获得文件夹大小，返回多少M
+ (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [Common fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

+ (UIColor *) colorWithHexString: (NSString *)color
{

    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
    
}


+ (UIImage *)createImageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}

+(MJRefreshGifHeader*)AddGifHeaderAndLoadDataFinished:(void (^)())finished
{
    NSMutableArray *Arr=[[NSMutableArray alloc]init];
    for (int i=1; i<=35; i++) {
        
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"mty%d",i]];
        [Arr addObject:image];
        
        [Arr addObject:image];
    }
    MJRefreshGifHeader *header =[MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        finished();

    }];
    // 设置普通状态的动画图片
    [header setImages:Arr forState:MJRefreshStateIdle];
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    [header setImages:Arr forState:MJRefreshStatePulling];
    // 设置正在刷新状态的动画图片
    [header setImages:Arr duration:1.0 forState:MJRefreshStateRefreshing];
    //     设置header

    return header;
    
}

/*
 密码不能为空 请重新输入
 不能有非法字符
 请输入至少6位英文及数字密码
 两次密码输入不一致 请重新输入
 */
+(BOOL)CheckPWByOnce:(NSString *)OncePW TwicePW:(NSString *)TwicePW
{
    NSString *msg=@"";
    if (OncePW.length==0||TwicePW.length==0) {
        msg=@"密码不能为空 请重新输入";
        
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"密码不能为空 请重新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return NO;
    }
    
    if ([self CheckIsIncludeNumAndWord:OncePW]==NO||[self CheckIsIncludeNumAndWord:TwicePW]==NO) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"密码不能有中文字符 请重新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return NO;
    }
    
    if (OncePW.length<6||OncePW.length>16 ||TwicePW.length<6||TwicePW.length>16) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"密码长度应6-16位 请重新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return NO;
    }
    
    if ([OncePW isEqualToString:TwicePW]==NO) {
        UIAlertView *av=[[UIAlertView alloc] initWithTitle:@"密码两次输入不一致 请重新输入" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
        return NO;
    }
    return YES;
}


#pragma mark - 根据字体大小多少计算尺寸
+ (CGRect)computeTextRectWith:(NSString *)text  andTextFont:(UIFont *)textFont andMaxWidth:(CGFloat)maxWidth
{
    //根据字数设置Text的尺寸
    CGSize maxSize = CGSizeMake(maxWidth,CGFLOAT_MAX);
    NSStringDrawingOptions opts = NSStringDrawingUsesLineFragmentOrigin |
    NSStringDrawingUsesFontLeading;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:NSLineBreakByCharWrapping];
    
    NSDictionary *attributes = @{ NSFontAttributeName : textFont, NSParagraphStyleAttributeName : style };
    CGRect rect;
    if (![text isKindOfClass:[NSNull class]]) {
        rect = [text boundingRectWithSize:maxSize
                                  options:opts
                               attributes:attributes
                                  context:nil];
    }
    return rect;
}

#pragma mark - 校验身份证号
+ (BOOL)CheckIsIdentityCard: (NSString *)identityCard
{
    //判断是否为空
    if (identityCard==nil||identityCard.length <= 0) {
        return NO;
    }
    //判断是否是18位，末尾是否是x
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if(![identityCardPredicate evaluateWithObject:identityCard]){
        return NO;
    }
    //判断生日是否合法
    NSRange range = NSMakeRange(6,8);
    NSString *datestr = [identityCard substringWithRange:range];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat : @"yyyyMMdd"];
    if([formatter dateFromString:datestr]==nil){
        return NO;
    }
    
    //判断校验位
    if(identityCard.length==18)
    {
        NSArray *idCardWi= @[ @"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2" ]; //将前17位加权因子保存在数组里
        NSArray * idCardY=@[ @"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2" ]; //这是除以11后，可能产生的11位余数、验证码，也保存成数组
        int idCardWiSum=0; //用来保存前17位各自乖以加权因子后的总和
        for(int i=0;i<17;i++){
            idCardWiSum+=[[identityCard substringWithRange:NSMakeRange(i,1)] intValue]*[idCardWi[i] intValue];
        }
        
        int idCardMod=idCardWiSum%11;//计算出校验码所在数组的位置
        NSString *idCardLast=[identityCard substringWithRange:NSMakeRange(17,1)];//得到最后一位身份证号码
        
        //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
        if(idCardMod==2){
            if([idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]){
                return YES;
            }else{
                return NO;
            }
        }else{
            //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
            if([idCardLast intValue]==[idCardY[idCardMod] intValue]){
                return YES;
            }else{
                return NO;
            }
        }
    }
    return NO;
}

/*  判断用户输入的密码是否符合规范，符合规范的密码要求：
1. 密码中必须同时包含数字和字母
*/
+(BOOL)judgeSafeStringLegal:(NSString *)pass{
    BOOL result = false;
    if ([pass length] >= 6){
        // 判断长度大于6位后再接着判断是否同时包含数字和字符
        NSString * regex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$";
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
        result = [pred evaluateWithObject:pass];
    }
    return result;
}

+ (NSString *)intervalFromLastDate: (NSString *) dateString1  toTheDate:(NSString *) dateString2
{
    NSArray *timeArray1=[dateString1 componentsSeparatedByString:@"."];
    dateString1=[timeArray1 objectAtIndex:0];
    
    
    NSArray *timeArray2=[dateString2 componentsSeparatedByString:@"."];
    dateString2=[timeArray2 objectAtIndex:0];
    
    NSLog(@"%@.....%@",dateString1,dateString2);
    NSDateFormatter *date=[[NSDateFormatter alloc] init];
    [date setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSDate *d1=[date dateFromString:dateString1];
    
    NSTimeInterval late1=[d1 timeIntervalSince1970]*1;
    
    NSDate *d2=[date dateFromString:dateString2];
    
    NSTimeInterval late2=[d2 timeIntervalSince1970]*1;
    
    NSTimeInterval cha=late2-late1;
    NSString *timeString=@"";
    NSString *house=@"";
    NSString *min=@"";
    NSString *sen=@"";
    
    sen = [NSString stringWithFormat:@"%d", (int)cha%60];
    //        min = [min substringToIndex:min.length-7];
    //    秒
    sen=[NSString stringWithFormat:@"%@", sen];
    
    min = [NSString stringWithFormat:@"%d", (int)cha/60%60];
    //        min = [min substringToIndex:min.length-7];
    //    分
    min=[NSString stringWithFormat:@"%@", min];
    
    
    //    小时
    house = [NSString stringWithFormat:@"%d", (int)cha/3600];
    //        house = [house substringToIndex:house.length-7];
    house=[NSString stringWithFormat:@"%@", house];

    timeString = [NSString stringWithFormat:@"%d",house.intValue*60*60 + min.intValue*60 + sen.intValue];
    
    return timeString;
}

// 去掉首尾空格
+ (NSString *)handleCommentStrEnumerationWithStr:(NSString *)string
{
    NSMutableString * outputString = [NSMutableString stringWithString:string];
    
    __block NSInteger spaceNumber = 0;
    
    // 先解决字符串前端的空格
    [outputString enumerateSubstringsInRange:NSMakeRange(0, outputString.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (![substring isEqualToString:@" "]) {
            * stop = YES;
            return ;
        }
        
        spaceNumber++;
    }];
    
    [outputString deleteCharactersInRange:NSMakeRange(0, spaceNumber)];
    
    // 然后反向遍历，解决字符串后端的空格
    spaceNumber = 0;
    [outputString enumerateSubstringsInRange:NSMakeRange(0, outputString.length) options:NSStringEnumerationByComposedCharacterSequences|NSStringEnumerationReverse usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if (![substring isEqualToString:@" "]) {
            * stop = YES;
            return ;
        }
        
        spaceNumber++;
    }];
    
    [outputString deleteCharactersInRange:NSMakeRange(outputString.length - spaceNumber, spaceNumber)];
    
    return outputString;
}


@end
