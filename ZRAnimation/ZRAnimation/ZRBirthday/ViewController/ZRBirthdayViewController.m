//
//  ZRBirthdayViewController.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayViewController.h"
#import "ZRBirthdayHeartMgr.h"
#import "ZRBirthdayEnvelopeMgr.h"
#import "ZRBirthdayEnvelopeModel.h"
#import "ZRAudioPlayerMgr.h"
#import "ZRDevice.h"

@interface ZRBirthdayViewController ()

@property (nonatomic, strong) IBOutlet UIButton *bgButton;

@end

@implementation ZRBirthdayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *imageName = ZRIPhoneXAll ? @"bg_iPhoneX.jpg" : @"bg_normal.jpg";
    [self.bgButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.title = @"生日快乐";
    [self actionEvent:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[ZRAudioPlayerMgr sharedInstance] stopMusic:ZRBirthdayMusicName];
}

- (IBAction)actionEvent:(id)sender {
    switch (self.birthdayType) {
        case ZRAnimationTypeHeart:
            [self showHeartBirthdayViewController];
            break;
        case ZRAnimationTypeEnvelopeOne:
            [self showEnvelopeBirthdayOneViewController];
            break;
        case ZRAnimationTypeEnvelopeTwo:
            [self showEnvelopeBirthdayTwoViewController];
            break;
        default:
            break;
    }
}

// 心形生日快乐
- (void)showHeartBirthdayViewController {
    ZRBirthdayHeartModel *birthdayModel = [[ZRBirthdayHeartModel alloc] init];
    birthdayModel.birthdayTitle = @"亲爱的戎马天涯";
    birthdayModel.birthdaySubTitle = @"我公司精心为您准备了3000元";
    birthdayModel.birthdayDescriptionTitle = @"生日礼金，和一份特别惊喜！";
    [[ZRBirthdayHeartMgr shareInstance] showBirthdayViewInViewController:self birthdayModel:birthdayModel receiveBlock:^{
        NSLog(@"动画完成后做一些处理");
    }];
}

// 信封生日祝福
- (void)showEnvelopeBirthdayOneViewController {
    ZRBirthdayEnvelopeModel *model = [[ZRBirthdayEnvelopeModel alloc] init];
    model.birthdayLayerName = @"亲爱的戎马天涯";
    model.birthdayLayerDesc = @"我公司精心为您准备了3000元生日礼金，赶快来领取吧";
    model.birthdayLayerType = ZRBirthdayLayerTypeForA;
    [[ZRBirthdayEnvelopeMgr shareInstance] showBirthdayViewController:self birthdayModel:model];
}

// 信封送好友生日祝福
- (void)showEnvelopeBirthdayTwoViewController {
    ZRBirthdayEnvelopeModel *model = [[ZRBirthdayEnvelopeModel alloc] init];
    model.birthdayLayerName = @"亲爱的戎马天涯";
    model.birthdayLayerDesc = @"您的好友高圆圆小姐过生日啦，快去送祝福吧";
    model.birthdayLayerType = ZRBirthdayLayerTypeForB;
    for (NSInteger i = 0; i < 1; ++i) {
        ZRBirthdayEnvelopeFriendsItem *item = [ZRBirthdayEnvelopeFriendsItem new];
        item.title = @"高小姐";
        item.isMore = i > 2;
        [model.friendsBirthdayInfo addObject:item];
    }
    [[ZRBirthdayEnvelopeMgr shareInstance] showBirthdayViewController:self birthdayModel:model];
}

- (void)dealloc {
    NSLog(@"%@",[self class]);
}

@end
