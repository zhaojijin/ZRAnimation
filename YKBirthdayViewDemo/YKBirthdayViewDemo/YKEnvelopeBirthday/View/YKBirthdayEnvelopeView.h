//
//  YKBirthdayEnvelopeView.h
//  YKBirthdayDemo
//
//  Created by zhaojijin on 2017/9/28.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YKBirthdayModel;

typedef void(^YKBirthdayReceiveActionBlock)();

typedef NS_ENUM(NSUInteger, YKBirthdayAnimationType) {
    YKBirthdayAnimationTypeUnknown,
    YKBirthdayAnimationTypeLidAnimationFirst,
    YKBirthdayAnimationTypeLidAnimationSecond,
    YKBirthdayAnimationTypeLetterPaperAnimation,
    YKBirthdayAnimationTypeShowButton
};

static NSString *const KYKBirthdayAnimationType = @"KYKBirthdayAnimationType";

@interface YKBirthdayEnvelopeView : UIView

@property (nonatomic, assign) CGFloat uiScale;
@property (nonatomic, strong) YKBirthdayModel *birthdayModel;
@property (nonatomic, copy) YKBirthdayReceiveActionBlock receiveActionBlock;

- (void)startCustomAnimation;

@end
