//
//  YKBirthdayAdapter.h
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/7/3.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import "YKTableViewBaseAdapter.h"
#import "YKBaseDefined.h"

@interface YKHomeAdapter : YKTableViewBaseAdapter

@property (nonatomic, copy) void(^birthdayClickBlock)(YKAnimationType birthdayType);

@end
