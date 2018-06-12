//
//  YKLayerBirthdayMgr.m
//  SimpleFinance
//
//  Created by zhaojijin on 2017/1/4.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import "YKLayerBirthdayMgr.h"
#import "YKBirthdayModel.h"
//#import "YKMainViewController.h"
//#import "YKBaseLibCommon.h"
//#import "YKBaseUICommon.h"
#import "YKBirthdayViewController.h"
#import "YKAudioPlayerMgr.h"

typedef void(^YKBirthdayControllerHiddenCompelectionBlock)();

static YKLayerBirthdayMgr *birthdayMgr = nil;

@interface YKLayerBirthdayMgr ()

@end

/* 生日动画idKey */
static NSString *const KYKBirthdayEventIdKey = @"KYKBirthdayEventIdKey";

@implementation YKLayerBirthdayMgr

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        birthdayMgr = [[YKLayerBirthdayMgr alloc] init];
    });
    return birthdayMgr;
}

- (BOOL)isShowBirthdayView {
    return YES;
}

- (void)showBirthdayViewController {
    dispatch_block_t block = ^{
        [self handleShowBirthdayViewControllerEvent];
    };
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)handleShowBirthdayViewControllerEvent {
    [self clearBirthdayViewController];
//    YKMainViewController *mainViewController = [AppDelegate mainViewController];
    YKBirthdayViewController *birthdayViewController = [[YKBirthdayViewController alloc] initWithNibName:@"YKBirthdayViewController" bundle:nil];
    birthdayViewController.birthdayModel = self.birthdayModel;
    __weak typeof(self) weakSelf = self;
    birthdayViewController.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf handleBirthdayLayerEnterWebViewEvent];
        }
    };
    birthdayViewController.birthdayLayerCloseBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf) {
            [strongSelf handleBirthdayLayerCloseEvent];
        }
    };
    self.birthdayViewController = birthdayViewController;
//    [birthdayViewController showInViewController:mainViewController];
}

- (void)handleBirthdayLayerCloseEvent {
    [self hiddenBirthdayViewController:^{
        
    }];
}

- (void)handleBirthdayLayerEnterWebViewEvent {
    __weak typeof(self) weakSelf = self;
    [self hiddenBirthdayViewController:^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf.birthdayModel.birthdayJumpLinkUrl.length > 0) {
            
        }
    }];
}

- (void)hiddenBirthdayViewController:(YKBirthdayControllerHiddenCompelectionBlock)compelectionBlock {
    [UIView animateWithDuration:0.5 animations:^{
        self.birthdayViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        [self stopBirthdayMusic];
        [self.birthdayViewController.view removeFromSuperview];
        [self.birthdayViewController removeFromParentViewController];
        self.birthdayViewController = nil;
        if (compelectionBlock) {
            compelectionBlock();
        }
    }];
}

- (void)clearBirthdayViewController {
    if (self.birthdayViewController) {
        [self stopBirthdayMusic];
        [self.birthdayViewController.view removeFromSuperview];
        [self.birthdayViewController removeFromParentViewController];
        self.birthdayViewController = nil;
    }
}

- (void)playBirthdayMusic {
    [[YKAudioPlayerMgr sharedInstance] playMusic:@"birthday.mp3" isLoops:YES];
}

- (void)stopBirthdayMusic {
    [[YKAudioPlayerMgr sharedInstance] stopMusic:@"birthday.mp3"];
}

@end
