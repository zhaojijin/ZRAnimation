//
//  UIColor+ZRColor.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZRColor)

+ (UIColor *)zr_colorWithValue:(NSUInteger)colorValue;
+ (UIColor *)zr_colorWithR:(CGFloat)r G:(CGFloat)g B:(CGFloat)b A:(CGFloat)a;

@end
