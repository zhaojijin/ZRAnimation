//
//  ZRBirthdayEnvelopeModel.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZRBirthdayEnvelopeFriendsItem.h"

typedef NS_ENUM(NSUInteger, ZRBirthdayLayerType) {
    ZRBirthdayLayerTypeUnknown,
    ZRBirthdayLayerTypeForA,   // A类用户生日弹层逻辑
    ZRBirthdayLayerTypeForB   // B类用户生日弹层逻辑
};

typedef NS_ENUM(NSUInteger, ZRBirthdayDurationStatus) {
    ZRBirthdayDurationStatusUnknown,
    ZRBirthdayDurationStatusIn,   // 在生日期内
    ZRBirthdayDurationStatusOut   // 不在生日期内
};

@interface ZRBirthdayEnvelopeModel : NSObject

@property (nonatomic, assign) ZRBirthdayDurationStatus isBirthdayDuration;
@property (nonatomic, strong) NSString *birthdayEventId;
@property (nonatomic, strong) NSString *birthdayJumpLinkUrl;
@property (nonatomic, strong) NSString *birthdayLayerName;
@property (nonatomic, strong) NSString *birthdayLayerDesc;
@property (nonatomic, assign) ZRBirthdayLayerType birthdayLayerType;
@property (nonatomic, strong) NSMutableArray <ZRBirthdayEnvelopeFriendsItem *>*friendsBirthdayInfo; // 最多三个

@end
