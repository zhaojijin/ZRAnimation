//
//  ZRBirthdayHeartMgr.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZRBirthdayHeartViewController.h"
#import "ZRBirthdayHeartModel.h"

@interface ZRBirthdayHeartMgr : NSObject

+ (instancetype)shareInstance;

- (void)showBirthdayViewInViewController:(UIViewController *)viewController birthdayModel:(ZRBirthdayHeartModel *)birthdayModel receiveBlock:(ZRBirthdayReceiveActionBlock)receiveBlock;

- (void)clearBirthdayViewController;

- (BOOL)isBirthdayViewControllerDisplaying;

@end

