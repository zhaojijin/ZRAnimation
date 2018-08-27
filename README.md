# YKBirthdayViewDemo

#### 效果演示

![](https://github.com/zhaojijin/YKBirthdayViewDemo/blob/master/Birthday2.gif)

#### 应用场景

项目中用户过生日时做活动用的native展示部分

#### 简单使用

```
// 心形生日快乐
- (void)showHeartBirthdayViewController {
    YKBirthdayItem *birthdayItem = [[YKBirthdayItem alloc] init];
    birthdayItem.birthdayTitle = @"亲爱的戎马天涯";
    birthdayItem.birthdaySubTitle = @"简理财精心为您准备了3000元";
    birthdayItem.birthdayDescriptionTitle = @"生日礼金，和一份特别惊喜！";
    [[YKBirthdayMgr shareInstance] showBirthdayViewInViewController:self birthdayItem:birthdayItem receiveBlock:^{
        NSLog(@"动画完成后做一些处理");
    }];
}

// 信封生日祝福
- (void)showEnvelopeBirthdayOneViewController {
    YKBirthdayModel *model = [[YKBirthdayModel alloc] init];
    model.birthdayLayerName = @"亲爱的戎马天涯";
    model.birthdayLayerDesc = @"简理财精心为您准备了3000元生日礼金，赶快来领取吧";
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

```
#### 声明转载请注明出处[https://github.com/zhaojijin/YKBirthdayViewDemo](https://github.com/zhaojijin/YKBirthdayViewDemo)
 
