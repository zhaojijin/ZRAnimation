//
//  ZRBirthdayEnvelopeMgr.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZRBirthdayEnvelopeModel;

@interface ZRBirthdayEnvelopeMgr : NSObject

+ (instancetype)shareInstance;

/**
 显示生日特权动画
 */
- (void)showBirthdayViewController:(UIViewController *)viewController birthdayModel:(ZRBirthdayEnvelopeModel *)birthdayModel;

/**
 清除生日弹层
 */
- (void)clearBirthdayViewController;

- (void)playBirthdayMusic;
- (void)stopBirthdayMusic;

@end
