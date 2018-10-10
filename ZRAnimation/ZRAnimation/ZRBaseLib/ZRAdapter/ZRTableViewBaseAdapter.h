//
//  ZRTableViewBaseAdapter.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRTableViewBaseAdapter : NSObject <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *itemList;

- (void)addDelegate:(UITableView *)tableView;

@end

