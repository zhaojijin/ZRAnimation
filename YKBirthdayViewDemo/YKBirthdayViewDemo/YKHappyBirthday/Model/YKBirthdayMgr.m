//
//  YKBirthdayMgr.m
//  SimpleFinance
//
//  Created by zhaojijin on 2016/11/21.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import "YKBirthdayMgr.h"
#import "YKHappyBirthdayViewController.h"
#import "YKAudioPlayerMgr.h"

typedef void(^YKBirthdayControllerHiddenCompelectionBlock)();

@interface YKBirthdayMgr ()

@property (nonatomic, strong) UIViewController *birthdayViewController;

@end

static YKBirthdayMgr *birthdayMgr = nil;

@implementation YKBirthdayMgr

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        birthdayMgr = [[YKBirthdayMgr alloc] init];
    });
    return birthdayMgr;
}

- (void)showBirthdayViewInViewController:(UIViewController *)viewController birthdayItem:(YKBirthdayItem *)birthdayItem {
    __weak typeof(self) weakSelf = self;
    dispatch_block_t block = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf showInViewController:viewController birthdayItem:birthdayItem];
        }
    };
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)showInViewController:(UIViewController *)viewController birthdayItem:(YKBirthdayItem *)birthdayItem {
    [self clearBirthdayViewController];

    YKHappyBirthdayViewController *birthdayViewController = [[YKHappyBirthdayViewController alloc] initWithNibName:@"YKHappyBirthdayViewController" bundle:nil];
    birthdayViewController.birthdayItem = birthdayItem;
    __weak typeof(self) weakSelf = self;
    birthdayViewController.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf hiddenBirthdayViewController:^{
                NSLog(@"动画完成后做一些处理");
            }];
        }
    };
    self.birthdayViewController = birthdayViewController;
    [birthdayViewController showInViewController:viewController];
}

- (void)hiddenBirthdayViewController:(YKBirthdayControllerHiddenCompelectionBlock)compelectionBlock {
    [UIView animateWithDuration:0.5 animations:^{
        [YKBirthdayMgr shareInstance].birthdayViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [[YKAudioPlayerMgr sharedInstance] stopMusic:@"birthday.mp3"];
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
        [[YKAudioPlayerMgr sharedInstance] stopMusic:@"birthday.mp3"];
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
