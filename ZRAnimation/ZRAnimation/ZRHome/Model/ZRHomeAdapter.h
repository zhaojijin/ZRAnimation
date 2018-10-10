//
//  ZRHomeAdapter.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRTableViewBaseAdapter.h"
#import "ZRBaseDefined.h"

@interface ZRHomeAdapter : ZRTableViewBaseAdapter

@property (nonatomic, copy) void(^birthdayClickBlock)(ZRAnimationType birthdayType);

@end
