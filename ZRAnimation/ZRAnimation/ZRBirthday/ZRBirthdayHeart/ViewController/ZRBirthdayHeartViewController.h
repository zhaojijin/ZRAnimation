//
//  ZRBirthdayHeartViewController.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBirthdayHeartView.h"
#import "ZRBirthdayHeartModel.h"

@interface ZRBirthdayHeartViewController : UIViewController

@property (nonatomic, copy) ZRBirthdayReceiveActionBlock receiveActionBlock;

@property (nonatomic, strong) ZRBirthdayHeartModel *birthdayModel;

- (void)showInViewController:(UIViewController *)viewController;

@end
