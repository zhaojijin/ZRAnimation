//
//  ZRBirthdayEnvelopeModel.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayEnvelopeModel.h"

@implementation ZRBirthdayEnvelopeModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.friendsBirthdayInfo = [NSMutableArray array];
    }
    return self;
}

@end
