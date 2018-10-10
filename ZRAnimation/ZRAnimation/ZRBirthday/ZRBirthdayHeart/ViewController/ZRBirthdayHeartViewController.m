//
//  ZRBirthdayHeartViewController.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayHeartViewController.h"

@interface ZRBirthdayHeartViewController ()

@property (nonatomic, strong) IBOutlet ZRBirthdayHeartView *birthdayView;

@property (nonatomic, strong) IBOutlet NSLayoutConstraint *birthdayViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *birthdayViewWidthConstraint;

@end

@implementation ZRBirthdayHeartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.birthdayViewHeightConstraint.constant = self.birthdayView.height;
    self.birthdayViewWidthConstraint.constant = self.birthdayView.width;
    [self handleBirthdayViewEvent];
}

- (void)handleBirthdayViewEvent {
    
    [self.birthdayView animationForBirthdayLid];
    
    self.birthdayView.birthdayTitle = self.birthdayModel.birthdayTitle;
    self.birthdayView.birthdaySubTitle = self.birthdayModel.birthdaySubTitle;
    self.birthdayView.birthdayDescritpion = self.birthdayModel.birthdayDescriptionTitle;
    __weak typeof(self) weakSelf = self;
    self.birthdayView.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf && strongSelf.receiveActionBlock) {
            strongSelf.receiveActionBlock();
        }
    };
}

- (void)showInViewController:(UIViewController *)viewController {
    [viewController addChildViewController:self];
    self.view.frame = viewController.view.frame;
    [viewController.view addSubview:self.view];
    [self didMoveToParentViewController:viewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    self.birthdayView.isCloseAnimation = YES;
    [self.birthdayView removeFromSuperview];
    self.birthdayView = nil;
}

@end
