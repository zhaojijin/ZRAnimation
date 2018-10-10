//
//  ZRDevice.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ZRDevice : NSObject

+ (BOOL)laterIOS9;

+ (NSString *)deviceUUID;

@end
