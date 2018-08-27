//
//  YKBirthdayAdapter.m
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/7/3.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import "YKBirthdayAdapter.h"
#import "YKHomeModel.h"

@implementation YKBirthdayAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        // 初始化数据
        for (NSInteger i = 0; i < 3; ++i) {
            YKHomeModel * model = [YKHomeModel new];
            if (i == 0) {
                model.title = @"心形生日祝福";
                model.birthdayType = YKBirthdayTypeHeart;
            } else if (i == 1) {
                model.title = @"打开信封生日祝福①";
                model.birthdayType = YKBirthdayTypeEnvelopeOne;
            } else if (i == 2) {
                model.title = @"打开信封生日祝福②";
                model.birthdayType = YKBirthdayTypeEnvelopeTwo;
            }
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
        YKHomeModel *model = self.itemList[row];
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
        YKHomeModel *model = self.itemList[row];
        if (self.birthdayClickBlock) {
            self.birthdayClickBlock(model.birthdayType);
        }
    }
}

@end
