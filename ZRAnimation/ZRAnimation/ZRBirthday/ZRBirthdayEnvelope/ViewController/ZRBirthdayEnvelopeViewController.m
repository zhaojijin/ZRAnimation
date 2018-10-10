//
//  ZRBirthdayEnvelopeViewController.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayEnvelopeViewController.h"
#import "ZRBirthdayEnvelopeModel.h"
#import "ZRAudioPlayerMgr.h"
#import "ZRBirthdayEnvelopeMgr.h"
#import "ZRDevice.h"

@interface ZRBirthdayEnvelopeViewController ()

@property (nonatomic, strong) IBOutlet ZRBirthdayEnvelopeView *envelopeView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *envelopeViewWidthConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *envelopeViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *closeButtonTopConstraint;

@end

@implementation ZRBirthdayEnvelopeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.envelopeViewWidthConstraint.constant = 304 * self.envelopeView.uiScale;
    self.envelopeViewHeightConstraint.constant = 386 * self.envelopeView.uiScale;
    if (ZRIPhone4) {
        self.closeButtonTopConstraint.constant = 15;
    } else if (ZRIPhone5) {
        self.closeButtonTopConstraint.constant = 30;
    }
    __weak typeof(self) weakSelf = self;
    self.envelopeView.receiveActionBlock = ^{
        typeof(self) strongSelf = weakSelf;
        if (strongSelf && strongSelf.receiveActionBlock) {
            strongSelf.receiveActionBlock();
        }
    };
    self.envelopeView.birthdayModel = self.birthdayModel;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 动画开始播放音乐
    [[ZRBirthdayEnvelopeMgr shareInstance] playBirthdayMusic];
    [self.envelopeView startCustomAnimation];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showInViewController:(UIViewController *)viewController {
    [viewController addChildViewController:self];
    self.view.frame = viewController.view.frame;
    [viewController.view addSubview:self.view];
    [self didMoveToParentViewController:viewController];
}

- (IBAction)dismiss:(id)sender {
    if (self.birthdayLayerCloseBlock) {
        self.birthdayLayerCloseBlock();
    }
}

@end
