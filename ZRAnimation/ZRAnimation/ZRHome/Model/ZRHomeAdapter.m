//
//  ZRHomeAdapter.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRHomeAdapter.h"
#import "ZRHomeModel.h"

@implementation ZRHomeAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        NSArray *titleList = @[@"心形生日祝福",@"打开信封生日祝福①",@"打开信封生日祝福②",@"卡片翻转动画",@"视频录制按钮",@"斜角进度条"];
        // 初始化数据
        for (NSInteger i = 0; i < titleList.count; ++i) {
            ZRHomeModel * model = [ZRHomeModel new];
            model.title = titleList[i];
            model.birthdayType = i+1;
            [self.itemList addObject:model];
        }
    }
    return self;
}

//提供默认实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemList.count;
}

//提供默认实现
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    NSInteger row = indexPath.row;
    if (row < self.itemList.count) {
        ZRHomeModel *model = self.itemList[row];
        cell.textLabel.text = model.title;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = indexPath.row;
    if (row < self.itemList.count) {
        ZRHomeModel *model = self.itemList[row];
        if (self.birthdayClickBlock) {
            self.birthdayClickBlock(model.birthdayType);
        }
    }
}

@end
