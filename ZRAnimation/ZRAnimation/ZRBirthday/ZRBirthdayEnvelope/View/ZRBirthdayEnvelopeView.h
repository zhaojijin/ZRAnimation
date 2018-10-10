//
//  ZRBirthdayEnvelopeView.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZRBirthdayEnvelopeModel;

typedef void(^ZRBirthdayReceiveActionBlock)(void);

typedef NS_ENUM(NSUInteger, ZRBirthdayAnimationType) {
    ZRBirthdayAnimationTypeUnknown,
    ZRBirthdayAnimationTypeLidAnimationFirst,
    ZRBirthdayAnimationTypeLidAnimationSecond,
    ZRBirthdayAnimationTypeLetterPaperAnimation,
    ZRBirthdayAnimationTypeShowButton
};

static NSString *const KZRBirthdayAnimationType = @"KZRBirthdayAnimationType";

@interface ZRBirthdayEnvelopeView : UIView

@property (nonatomic, assign) CGFloat uiScale;
@property (nonatomic, strong) ZRBirthdayEnvelopeModel *birthdayModel;
@property (nonatomic, copy) ZRBirthdayReceiveActionBlock receiveActionBlock;

- (void)startCustomAnimation;

@end
