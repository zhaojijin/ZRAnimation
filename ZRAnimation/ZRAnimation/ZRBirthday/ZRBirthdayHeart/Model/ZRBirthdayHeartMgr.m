//
//  ZRBirthdayHeartMgr.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayHeartMgr.h"
#import "ZRAudioPlayerMgr.h"

typedef void(^ZRBirthdayControllerHiddenCompelectionBlock)(void);

@interface ZRBirthdayHeartMgr ()

@property (nonatomic, strong) UIViewController *birthdayViewController;

@end

static ZRBirthdayHeartMgr *birthdayMgr = nil;

@implementation ZRBirthdayHeartMgr

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        birthdayMgr = [[ZRBirthdayHeartMgr alloc] init];
    });
    return birthdayMgr;
}

- (void)showBirthdayViewInViewController:(UIViewController *)viewController birthdayModel:(ZRBirthdayHeartModel *)birthdayModel receiveBlock:(ZRBirthdayReceiveActionBlock)receiveBlock {
    __weak typeof(self) weakSelf = self;
    dispatch_block_t block = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf showInViewController:viewController birthdayModel:birthdayModel receiveBlock:receiveBlock];
        }
    };
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)showInViewController:(UIViewController *)viewController birthdayModel:(ZRBirthdayHeartModel *)birthdayModel receiveBlock:(ZRBirthdayReceiveActionBlock)receiveBlock {
    [self clearBirthdayViewController];
    
    ZRBirthdayHeartViewController *birthdayViewController = [[ZRBirthdayHeartViewController alloc] initWithNibName:@"ZRBirthdayHeartViewController" bundle:nil];
    birthdayViewController.birthdayModel = birthdayModel;
    __weak typeof(self) weakSelf = self;
    birthdayViewController.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf hiddenBirthdayViewController:^{
                if (receiveBlock) {
                    receiveBlock();
                }
            }];
        }
    };
    self.birthdayViewController = birthdayViewController;
    [birthdayViewController showInViewController:viewController];
}

- (void)hiddenBirthdayViewController:(ZRBirthdayControllerHiddenCompelectionBlock)compelectionBlock {
    [UIView animateWithDuration:0.5 animations:^{
        [ZRBirthdayHeartMgr shareInstance].birthdayViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [[ZRAudioPlayerMgr sharedInstance] stopMusic:ZRBirthdayMusicName];
        [self.birthdayViewController removeFromParentViewController];
        [self.birthdayViewController.view removeFromSuperview];
        self.birthdayViewController = nil;
        if (compelectionBlock) {
            compelectionBlock();
        }
    }];
}

- (void)clearBirthdayViewController {
    if (self.birthdayViewController) {
        [[ZRAudioPlayerMgr sharedInstance] stopMusic:ZRBirthdayMusicName];
        [self.birthdayViewController.view removeFromSuperview];
        [self.birthdayViewController removeFromParentViewController];
        self.birthdayViewController = nil;
    }
}

- (BOOL)isBirthdayViewControllerDisplaying {
    if (self.birthdayViewController) {
        return YES;
    } else {
        return NO;
    }
}

@end
