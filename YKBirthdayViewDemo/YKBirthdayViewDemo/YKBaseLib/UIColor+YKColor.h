//
//  UIColor+YKColor.h
//  YKBirthdayViewDemo
//
//  Created by zhaojijin on 2017/10/27.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (YKColor)

+ (UIColor *)yk_colorWithValue:(NSUInteger)colorValue;
+ (UIColor *)yk_colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

@end
