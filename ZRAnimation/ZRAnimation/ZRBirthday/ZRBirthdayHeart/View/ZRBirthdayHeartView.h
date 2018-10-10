//
//  ZRBirthdayHeartView.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ZRBirthdayAnimationType) {
    ZRBirthdayAnimationTypeUnknown,
    ZRBirthdayAnimationTypeLidGroup,
    ZRBirthdayAnimationTypeHappyBirthdayShow,
    ZRBirthdayAnimationTypeHappyBirthdayHidden,
};

typedef void(^ZRBirthdayReceiveActionBlock)(void);

@interface ZRBirthdayHeartView : UIView

/**
 动画界面整体高度
 */
@property (nonatomic, assign, readonly) CGFloat height;
/**
 动画界面整体宽度
 */
@property (nonatomic, assign, readonly) CGFloat width;

@property (nonatomic, strong) NSString *birthdayTitle;
@property (nonatomic, strong) NSString *birthdaySubTitle;
@property (nonatomic, strong) NSString *birthdayDescritpion;

@property (nonatomic, copy) ZRBirthdayReceiveActionBlock receiveActionBlock;

/**
 controller销毁时设为yes 处理动画代理强引用造成的循环引用问题
 */
@property (nonatomic, assign) BOOL isCloseAnimation;

/**
 盒子打开动画
 */
- (void)animationForBirthdayLid;

@end
