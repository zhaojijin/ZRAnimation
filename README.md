# YKBirthdayViewDemo

#### 应用场景

项目中用户过生日时做活动用的native展示部分

#### 简单使用

```
YKBirthdayItem *birthdayItem = [[YKBirthdayItem alloc] init];
birthdayItem.birthdayTitle = @"亲爱的戎马天涯";
birthdayItem.birthdaySubTitle = @"简理财精心为您准备了3000元";
birthdayItem.birthdayDescriptionTitle = @"生日礼金，和一份特别惊喜！";
[[YKBirthdayMgr shareInstance] showBirthdayViewInViewController:self birthdayItem:birthdayItem receiveBlock:^{
   NSLog(@"动画完成后做一些处理");
}];

```


#### 效果图演示

![](https://github.com/zhaojijin/YKBirthdayViewDemo/blob/master/Birthday1.gif)
