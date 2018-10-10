# ZRAnimation

#### 效果演示

![](https://github.com/zhaojijin/ZRAnimation/blob/master/Birthday.gif)
![](https://github.com/zhaojijin/ZRAnimation/blob/master/CardDance.gif)

#### 简单使用

```
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

// 简单卡片翻转动画
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"卡片翻转";
    // 可根据业务需求来自定义Model，在ZRCardDanceFrontView和ZRCardDanceReverseSideView中自定义UI
    ZRCardDanceView *cardDanceView = [[ZRCardDanceView alloc] initWithFrame:CGRectMake(0, 0, 172.5, 250) model:nil];
    cardDanceView.center = CGPointMake(ZRScreenW/2, ZRScreenH/2);
    [self.view addSubview:cardDanceView];
}

```
#### 有任何感觉不妥的地方请您给出宝贵的意见，谢谢！
 
