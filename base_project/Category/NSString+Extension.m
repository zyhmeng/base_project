//
//  NSString+Extension.m
//  NStringExtension
//
//  Created by zyh on 16/8/19.
//  Copyright © 2016年 zyh. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (BOOL)CheckIsTelNum
{
    if ([self length] == 0) {
        
        return NO;
    }
    
    NSString *regex = @"^(1)\\d{10}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:self];
    
    if (!isMatch) {
        return NO;
    }
    return YES;
}

- (BOOL)isValidateEmail
{
    
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

- (BOOL)stringIsEmpty
{
    return (self == nil || [self isEqualToString:@""]);
}


- (CGSize)sizeWithFont:(UIFont *)font maxWidth:(CGFloat)maxWidth
{
    //1.
    NSDictionary *attrs = @{
                            NSFontAttributeName : font
                            };
    
    //2.
    CGSize maxSize = CGSizeMake(maxWidth, MAXFLOAT);
    
    //3.
    return [self boundingRectWithSize:maxSize
                              options:NSStringDrawingUsesLineFragmentOrigin
                           attributes:attrs
                              context:nil].size;
}


@end
