//
//  YKDevice.h
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/3/27.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 * 设备尺寸的类型
 */
typedef NS_ENUM(NSInteger, YKDeviceType) {
    YKDeviceTypeNone,
    YKDeviceType4S,                               //3.5英寸屏幕
    YKDeviceType5S,                               //4英寸屏幕
    YKDeviceType6,                                //4.7英寸屏幕
    YKDeviceType6P,                               //5.5英寸屏幕
    YKDeviceTypeX                                 //5.8英寸屏幕
};

@interface YKDevice : NSObject

+ (BOOL)laterIOS9;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)navigationBarHeight;

+ (CGFloat)navigationAndStatusBarHeight;

+ (NSString *)deviceUUID;

+ (CGFloat)uiScaleForWidth;

+ (YKDeviceType)deviceType;

@end
