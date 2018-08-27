//
//  YKDetailViewController.m
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/7/3.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import "YKDetailViewController.h"
#import "YKBirthdayMgr.h"
#import "YKBirthdayEnvelopeMgr.h"
#import "YKBirthdayModel.h"
#import "YKAudioPlayerMgr.h"

@interface YKDetailViewController ()

@property (nonatomic, strong) IBOutlet UIButton *bgButton;

@end

@implementation YKDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    BOOL iPhoneX = [UIScreen mainScreen].bounds.size.height == 812;
    NSString *imageName = iPhoneX ? @"bg_iPhoneX.jpg" : @"bg_normal.jpg";
    [self.bgButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    self.title = @"生日快乐";
    [self actionEvent:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [[YKAudioPlayerMgr sharedInstance] stopMusic:ykBirthdayMusicName];
}

- (IBAction)actionEvent:(id)sender {
    switch (self.birthdayType) {
        case YKBirthdayTypeHeart:
            [self showHeartBirthdayViewController];
            break;
        case YKBirthdayTypeEnvelopeOne:
            [self showEnvelopeBirthdayOneViewController];
            break;
        case YKBirthdayTypeEnvelopeTwo:
            [self showEnvelopeBirthdayTwoViewController];
            break;
        default:
            break;
    }
}

// 心形生日快乐
- (void)showHeartBirthdayViewController {
    YKBirthdayItem *birthdayItem = [[YKBirthdayItem alloc] init];
    birthdayItem.birthdayTitle = @"亲爱的戎马天涯";
    birthdayItem.birthdaySubTitle = @"我公司精心为您准备了3000元";
    birthdayItem.birthdayDescriptionTitle = @"生日礼金，和一份特别惊喜！";
    [[YKBirthdayMgr shareInstance] showBirthdayViewInViewController:self birthdayItem:birthdayItem receiveBlock:^{
        NSLog(@"动画完成后做一些处理");
    }];
}

// 信封生日祝福
- (void)showEnvelopeBirthdayOneViewController {
    YKBirthdayModel *model = [[YKBirthdayModel alloc] init];
    model.birthdayLayerName = @"亲爱的戎马天涯";
    model.birthdayLayerDesc = @"我公司精心为您准备了3000元生日礼金，赶快来领取吧";
    model.birthdayLayerType = YKBirthdayLayerTypeForA;
    [[YKBirthdayEnvelopeMgr shareInstance] showBirthdayViewController:self birthdayModel:model];
}

// 信封送好友生日祝福
- (void)showEnvelopeBirthdayTwoViewController {
    YKBirthdayModel *model = [[YKBirthdayModel alloc] init];
    model.birthdayLayerName = @"亲爱的戎马天涯";
    model.birthdayLayerDesc = @"您的好友高圆圆小姐过生日啦，快去送祝福吧";
    model.birthdayLayerType = YKBirthdayLayerTypeForB;
    for (NSInteger i = 0; i < 1; ++i) {
        YKBirthdayFriendsItem *item = [YKBirthdayFriendsItem new];
        item.title = @"高小姐";
        item.isMore = i > 2;
        [model.friendsBirthdayInfo addObject:item];
    }
    [[YKBirthdayEnvelopeMgr shareInstance] showBirthdayViewController:self birthdayModel:model];
}

- (void)dealloc {
    NSLog(@"%@",[self class]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
