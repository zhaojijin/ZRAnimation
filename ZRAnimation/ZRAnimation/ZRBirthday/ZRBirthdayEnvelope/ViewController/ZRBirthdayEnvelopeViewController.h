//
//  ZRBirthdayEnvelopeViewController.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZRBirthdayEnvelopeView.h"

typedef void(^ZRBirthdayLayerCloseBlock)(void);

@class ZRBirthdayEnvelopeModel;

@interface ZRBirthdayEnvelopeViewController : UIViewController

@property (nonatomic, strong) ZRBirthdayEnvelopeModel *birthdayModel;
@property (nonatomic, copy) ZRBirthdayReceiveActionBlock receiveActionBlock;
@property (nonatomic, copy) ZRBirthdayLayerCloseBlock birthdayLayerCloseBlock;

- (void)showInViewController:(UIViewController *)viewController;

@end
