//
//  YKLayerBirthdayMgr.h
//  SimpleFinance
//
//  Created by zhaojijin on 2017/1/4.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YKBirthdayModel;
@class YKBirthdayViewController;

@interface YKLayerBirthdayMgr : NSObject

@property (nonatomic, strong) YKBirthdayViewController *birthdayViewController;
@property (nonatomic, strong) YKBirthdayModel *birthdayModel;

+ (instancetype)shareInstance;

- (BOOL)isShowBirthdayView;

/**
 显示生日特权动画
 */
- (void)showBirthdayViewController;

/**
 清除生日弹层
 */
- (void)clearBirthdayViewController;

- (void)playBirthdayMusic;
- (void)stopBirthdayMusic;

@end
