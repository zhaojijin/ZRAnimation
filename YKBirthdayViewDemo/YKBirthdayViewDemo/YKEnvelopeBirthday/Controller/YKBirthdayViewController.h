//
//  YKBirthdayViewController.h
//  YKBirthdayDemo
//
//  Created by zhaojijin on 2017/9/29.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YKBirthdayEnvelopeView.h"
//#import "YKBaseViewController.h"

typedef void(^YKBirthdayLayerCloseBlock)(void);

@class YKBirthdayModel;

@interface YKBirthdayViewController : UIViewController

@property (nonatomic, strong) YKBirthdayModel *birthdayModel;
@property (nonatomic, copy) YKBirthdayReceiveActionBlock receiveActionBlock;
@property (nonatomic, copy) YKBirthdayLayerCloseBlock birthdayLayerCloseBlock;

- (void)showInViewController:(UIViewController *)viewController;

@end
