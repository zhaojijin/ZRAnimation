//
//  ZRDevice.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRDevice.h"

static NSString *const KZRDeviceUUIDKey = @"ZRDeviceUUIDKey";

@implementation ZRDevice

+ (BOOL)laterIOS9 {
    return UIDevice.currentDevice.systemVersion.intValue >= 9;
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

@end
