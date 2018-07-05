//
//  YKBirthdayModel.h
//  YKBirthdayDemo
//
//  Created by zhaojijin on 2017/9/30.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YKBirthdayFriendsItem.h"

typedef NS_ENUM(NSUInteger, YKBirthdayLayerType) {
    YKBirthdayLayerTypeUnknown,
    YKBirthdayLayerTypeForA,   // A类用户生日弹层逻辑
    YKBirthdayLayerTypeForB   // B类用户生日弹层逻辑
};

typedef NS_ENUM(NSUInteger, YKBirthdayDurationStatus) {
    YKBirthdayDurationStatusUnknown,
    YKBirthdayDurationStatusIn,   // 在生日期内
    YKBirthdayDurationStatusOut   // 不在生日期内
};

@interface YKBirthdayModel : NSObject

@property (nonatomic, assign) YKBirthdayDurationStatus isBirthdayDuration;
@property (nonatomic, strong) NSString *birthdayEventId;
@property (nonatomic, strong) NSString *birthdayJumpLinkUrl;
@property (nonatomic, strong) NSString *birthdayLayerName;
@property (nonatomic, strong) NSString *birthdayLayerDesc;
@property (nonatomic, assign) YKBirthdayLayerType birthdayLayerType;
@property (nonatomic, strong) NSMutableArray <YKBirthdayFriendsItem *>*friendsBirthdayInfo; // 最多三个

@end
