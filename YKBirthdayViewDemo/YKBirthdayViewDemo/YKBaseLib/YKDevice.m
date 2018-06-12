//
//  YKDevice.m
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/3/27.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import "YKDevice.h"

static NSString *const KYKDeviceUUIDKey = @"YKDeviceUUIDKey";
static CGSize const KYKDeviceScreenSize4S = {320,480};
static CGSize const KYKDeviceScreenSize5S = {320,568};
static CGSize const KYKDeviceScreenSize6 = {375,667};
static CGSize const KYKDeviceScreenSize6Plus = {414,736};
static CGSize const KYKDeviceScreenSizeX = {375,812};

@implementation YKDevice

+ (CGSize)deviceScreenSize {
    return [UIScreen mainScreen].bounds.size;
}

+ (BOOL)laterIOS9 {
    return UIDevice.currentDevice.systemVersion.intValue >= 9;
}

+ (CGFloat)screenWidth {
    return [YKDevice deviceScreenSize].width;
}

+ (CGFloat)screenHeight {
    return [YKDevice deviceScreenSize].height;
}

+ (CGFloat)navigationBarHeight {
    return 44.0;
}

+ (CGFloat)navigationAndStatusBarHeight {
    return [[UIApplication sharedApplication] statusBarFrame].size.height + 44.0;
}

+ (NSString *)deviceUUID {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *deviceUUID = [userDefaults objectForKey:KYKDeviceUUIDKey];
    if (deviceUUID.length == 0) {
        CFUUIDRef ref = CFUUIDCreate(nil);
        deviceUUID = (NSString *)CFBridgingRelease(CFUUIDCreateString(nil, ref));
        CFRelease(ref);
        
        if (deviceUUID) {
            [userDefaults setObject:deviceUUID forKey:KYKDeviceUUIDKey];
            [userDefaults synchronize];
        }
    }
    return deviceUUID;
}

+ (CGFloat)uiScaleForWidth {
    return [YKDevice deviceScreenSize].width / 375.0;
}

+ (YKDeviceType)deviceType {
    CGSize size = [YKDevice deviceScreenSize];
    if (CGSizeEqualToSize(size, KYKDeviceScreenSize4S)) {
        return YKDeviceType4S;
    } else if (CGSizeEqualToSize(size, KYKDeviceScreenSize5S)) {
        return YKDeviceType5S;
    } else if (CGSizeEqualToSize(size, KYKDeviceScreenSize6)) {
        return YKDeviceType6;
    } else if (CGSizeEqualToSize(size, KYKDeviceScreenSize6Plus)) {
        return YKDeviceType6P;
    } else if (CGSizeEqualToSize(size, KYKDeviceScreenSizeX)) {
        return YKDeviceTypeX;
    } else {
        return YKDeviceTypeNone;
    }
}

@end
