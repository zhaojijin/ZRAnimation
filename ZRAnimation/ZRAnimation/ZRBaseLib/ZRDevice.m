//
//  ZRDevice.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRDevice.h"

static NSString *const KZRDeviceUUIDKey = @"ZRDeviceUUIDKey";
static CGSize const KZRDeviceScreenSize4S = {320,480};
static CGSize const KZRDeviceScreenSize5S = {320,568};
static CGSize const KZRDeviceScreenSize6 = {375,667};
static CGSize const KZRDeviceScreenSize6Plus = {414,736};
static CGSize const KZRDeviceScreenSizeX = {375,812};
static CGSize const KZRDeviceScreenSizeXM = {414,896};

@implementation ZRDevice

+ (CGSize)deviceScreenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (BOOL)laterIOS9 {
    return UIDevice.currentDevice.systemVersion.intValue >= 9;
}

+ (CGFloat)screenWidth {
    return [ZRDevice deviceScreenSize].width;
}

+ (CGFloat)screenHeight {
    return [ZRDevice deviceScreenSize].height;
}

+ (CGFloat)navigationBarHeight {
    return 44.0;
}

+ (CGFloat)navigationAndStatusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height + 44.0;
}

+ (NSString *)deviceUUID {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceUUID = [userDefaults objectForKey:KZRDeviceUUIDKey];
    if (deviceUUID.length == 0) {
        CFUUIDRef ref = CFUUIDCreate(nil);
        deviceUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, ref));
        CFRelease(ref);
        
        if (deviceUUID) {
            [userDefaults setObject:deviceUUID forKey:KZRDeviceUUIDKey];
            [userDefaults synchronize];
        }
    }
    return deviceUUID;
}

+ (CGFloat)uiScaleForWidth {
    return [ZRDevice deviceScreenSize].width / 375.0;
}

+ (ZRDeviceType)deviceType {
    CGSize size = [ZRDevice deviceScreenSize];
    if (CGSizeEqualToSize(size, KZRDeviceScreenSize4S)) {
        return ZRDeviceType4S;
    } else if (CGSizeEqualToSize(size, KZRDeviceScreenSize5S)) {
        return ZRDeviceType5S;
    } else if (CGSizeEqualToSize(size, KZRDeviceScreenSize6)) {
        return ZRDeviceType6;
    } else if (CGSizeEqualToSize(size, KZRDeviceScreenSize6Plus)) {
        return ZRDeviceType6P;
    } else if (CGSizeEqualToSize(size, KZRDeviceScreenSizeX)) {
        return ZRDeviceTypeX;
    } else if (CGSizeEqualToSize(size, KZRDeviceScreenSizeXM)) {
        return ZRDeviceTypeXM;
    } else {
        return ZRDeviceTypeNone;
    }
}

@end
