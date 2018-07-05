//
//  YKLayerBirthdayMgr.h
//  SimpleFinance
//
//  Created by zhaojijin on 2017/1/4.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class YKBirthdayModel;

@interface YKBirthdayEnvelopeMgr : NSObject

+ (instancetype)shareInstance;

/**
 显示生日特权动画
 */
- (void)showBirthdayViewController:(UIViewController *)viewController birthdayModel:(YKBirthdayModel *)birthdayModel;

/**
 清除生日弹层
 */
- (void)clearBirthdayViewController;

- (void)playBirthdayMusic;
- (void)stopBirthdayMusic;

@end
