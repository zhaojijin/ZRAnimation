//
//  ZRDevice.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 * 设备尺寸的类型
 */
typedef NS_ENUM(NSInteger, ZRDeviceType) {
    ZRDeviceTypeNone,
    ZRDeviceType4S,                               //3.5英寸屏幕
    ZRDeviceType5S,                               //4英寸屏幕
    ZRDeviceType6,                                //4.7英寸屏幕
    ZRDeviceType6P,                               //5.5英寸屏幕
    ZRDeviceTypeX,                                //5.8英寸屏幕 X、XS
    ZRDeviceTypeXM                                //XR XSM
};

@interface ZRDevice : NSObject

+ (BOOL)laterIOS9;

+ (CGFloat)screenWidth;

+ (CGFloat)screenHeight;

+ (CGFloat)navigationBarHeight;

+ (CGFloat)navigationAndStatusBarHeight;

+ (NSString *)deviceUUID;

+ (CGFloat)uiScaleForWidth;

+ (ZRDeviceType)deviceType;

@end
