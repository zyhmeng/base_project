//
//  NSDictionary+YF.h
//  base_project
//
//  Created by jangbuk on 16/3/8.
//  Copyright © 2016年 jangbuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (YF)
/**
 *  将对象中 所有空值 进行空字符串转换
 *
 *  @param myObj 待转换的obj
 *
 *  @return 将待转换的obj 字典中 所有 NSNull类型转换成 @""
 */
+(id)changeType:(id)myObj;
@end
