//
//  YKBirthdayModel.m
//  YKBirthdayDemo
//
//  Created by zhaojijin on 2017/9/30.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import "YKBirthdayModel.h"

@implementation YKBirthdayModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.friendsBirthdayInfo = [NSMutableArray array];
    }
    return self;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"friendsBirthdayInfo" : [YKBirthdayFriendsItem class]};
}

@end
