//
//  YKBirthdayView.h
//  birthdayAnimation
//
//  Created by zhaojijin on 2016/11/17.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YKBirthdayAnimationType) {
    YKBirthdayAnimationTypeUnknown,
    YKBirthdayAnimationTypeLidGroup,
    YKBirthdayAnimationTypeHappyBirthdayShow,
    YKBirthdayAnimationTypeHappyBirthdayHidden,
};

typedef void(^YKBirthdayReceiveActionBlock)();

@interface YKBirthdayView : UIView

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

@property (nonatomic, copy) YKBirthdayReceiveActionBlock receiveActionBlock;

/** 
 controller销毁时设为yes 处理动画代理强引用造成的循环引用问题 
 */
@property (nonatomic, assign) BOOL isCloseAnimation;

/**
 盒子打开动画
 */
- (void)animationForBirthdayLid;

@end
