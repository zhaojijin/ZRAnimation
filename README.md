# YKBirthdayViewDemo

#### 效果演示

![](https://github.com/zhaojijin/YKBirthdayViewDemo/blob/master/Birthday.gif)
![](https://github.com/zhaojijin/YKBirthdayViewDemo/blob/master/CardDance.gif)

#### 应用场景

项目中用户过生日时做活动用的native展示部分

#### 简单使用

```
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

// 简单卡片翻转动画
- (void)viewDidLoad {
    [super viewDidLoad];
    // 可根据业务需求来自定义Model，在ZRCardDanceFrontView和ZRCardDanceReverseSideView中自定义UI
    ZRCardDanceView *cardDanceView = [[ZRCardDanceView alloc] initWithFrame:CGRectMake(0, 0, 172.5, 250) model:nil];
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    cardDanceView.center = CGPointMake(screenSize.width/2, screenSize.height/2);
    [self.view addSubview:cardDanceView];
}

```
<font color = red>有任何感觉不妥的地方请您给出宝贵的意见，谢谢！</font>
#### 声明转载请注明出处[https://github.com/zhaojijin/YKBirthdayViewDemo](https://github.com/zhaojijin/YKBirthdayViewDemo)
 
