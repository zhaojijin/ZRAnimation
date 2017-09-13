//
//  YKHappyBirthdayViewController.h
//  SimpleFinance
//
//  Created by zhaojijin on 2016/11/21.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKBirthdayView.h"
#import "YKBirthdayItem.h"

@interface YKHappyBirthdayViewController : UIViewController

@property (nonatomic, copy) YKBirthdayReceiveActionBlock receiveActionBlock;

@property (nonatomic, strong) YKBirthdayItem *birthdayItem;

- (void)showInViewController:(UIViewController *)viewController;

@end
