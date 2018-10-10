//
//  ZRBirthdayEnvelopeMgr.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayEnvelopeMgr.h"
#import "ZRBirthdayEnvelopeModel.h"
#import "ZRBirthdayEnvelopeViewController.h"
#import "ZRAudioPlayerMgr.h"

typedef void(^ZRBirthdayControllerHiddenCompelectionBlock)(void);

@interface ZRBirthdayEnvelopeMgr ()

@property (nonatomic, strong) ZRBirthdayEnvelopeModel *birthdayModel;
@property (nonatomic, strong) ZRBirthdayEnvelopeViewController *birthdayViewController;

@end

/* 生日动画idKey */
static NSString *const KZRBirthdayEventIdKey = @"KZRBirthdayEventIdKey";
static ZRBirthdayEnvelopeMgr *birthdayMgr = nil;

@implementation ZRBirthdayEnvelopeMgr

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        birthdayMgr = [[ZRBirthdayEnvelopeMgr alloc] init];
    });
    return birthdayMgr;
}

- (BOOL)isShowBirthdayView {
    return YES;
}

- (void)showBirthdayViewController:(UIViewController *)viewController birthdayModel:(ZRBirthdayEnvelopeModel *)birthdayModel {
    self.birthdayModel = birthdayModel;
    dispatch_block_t block = ^{
        [self handleShowBirthdayViewControllerEvent:viewController];
    };
    if ([NSThread isMainThread]) {
        block();
    } else {
        dispatch_async(dispatch_get_main_queue(), block);
    }
}

- (void)handleShowBirthdayViewControllerEvent:(UIViewController *)viewController  {
    [self clearBirthdayViewController];
    ZRBirthdayEnvelopeViewController *birthdayViewController = [[ZRBirthdayEnvelopeViewController alloc] initWithNibName:@"ZRBirthdayEnvelopeViewController" bundle:nil];
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
    [birthdayViewController showInViewController:viewController];
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

- (void)hiddenBirthdayViewController:(ZRBirthdayControllerHiddenCompelectionBlock)compelectionBlock {
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
    [[ZRAudioPlayerMgr sharedInstance] playMusic:ZRBirthdayMusicName isLoops:YES];
}

- (void)stopBirthdayMusic {
    [[ZRAudioPlayerMgr sharedInstance] stopMusic:ZRBirthdayMusicName];
}

@end
