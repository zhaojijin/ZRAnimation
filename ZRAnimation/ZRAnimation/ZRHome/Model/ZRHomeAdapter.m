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
        // 初始化数据
        for (NSInteger i = 0; i < 4; ++i) {
            ZRHomeModel * model = [ZRHomeModel new];
            if (i == 0) {
                model.title = @"心形生日祝福";
            } else if (i == 1) {
                model.title = @"打开信封生日祝福①";
            } else if (i == 2) {
                model.title = @"打开信封生日祝福②";
            } else if (i == 3) {
                model.title = @"卡片翻转动画";
            }
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
