//
//  YKTableViewBaseAdapter.m
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/7/3.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import "YKTableViewBaseAdapter.h"

@implementation YKTableViewBaseAdapter

- (instancetype)init {
    self = [super init];
    if (self) {
        self.itemList = [NSMutableArray array];
    }
    return self;
}

- (void)addDelegate:(UITableView *)tableView {
    tableView.delegate = self;
    tableView.dataSource = self;
}

//提供默认实现
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemList.count;
}

//提供默认实现
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * showUserInfoCellIdentifier = @"customCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:showUserInfoCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:showUserInfoCellIdentifier];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 0;
}

@end
