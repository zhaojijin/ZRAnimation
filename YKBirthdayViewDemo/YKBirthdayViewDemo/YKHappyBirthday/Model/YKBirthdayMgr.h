//
//  YKBirthdayMgr.h
//  SimpleFinance
//
//  Created by zhaojijin on 2016/11/21.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YKBirthdayItem.h"

@interface YKBirthdayMgr : NSObject

+ (instancetype)shareInstance;

- (void)showBirthdayViewInViewController:(UIViewController *)viewController birthdayItem:(YKBirthdayItem *)birthdayItem;

- (void)clearBirthdayViewController;

- (BOOL)isBirthdayViewControllerDisplaying;

@end
