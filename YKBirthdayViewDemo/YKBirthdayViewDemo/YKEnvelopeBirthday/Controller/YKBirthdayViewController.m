//
//  YKBirthdayViewController.m
//  YKBirthdayDemo
//
//  Created by zhaojijin on 2017/9/29.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import "YKBirthdayViewController.h"
#import "YKBirthdayEnvelopeView.h"
#import "YKBirthdayModel.h"
#import "YKAudioPlayerMgr.h"
#import "YKBirthdayEnvelopeMgr.h"
#import "YKDevice.h"

@interface YKBirthdayViewController ()

@property (nonatomic, strong) IBOutlet YKBirthdayEnvelopeView *envelopeView;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *envelopeViewWidthConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *envelopeViewHeightConstraint;
@property (nonatomic, strong) IBOutlet NSLayoutConstraint *closeButtonTopConstraint;

@end

@implementation YKBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.envelopeViewWidthConstraint.constant = 304 * self.envelopeView.uiScale;
    self.envelopeViewHeightConstraint.constant = 386 * self.envelopeView.uiScale;
    switch ([YKDevice deviceType]) {
        case YKDeviceType4S:
            self.closeButtonTopConstraint.constant = 15;
            break;
        case YKDeviceType5S:
            self.closeButtonTopConstraint.constant = 30;
            break;
        default:
            break;
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
    [[YKBirthdayEnvelopeMgr shareInstance] playBirthdayMusic];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
