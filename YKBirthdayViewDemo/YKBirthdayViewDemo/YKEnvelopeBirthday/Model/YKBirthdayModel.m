//
//  YKBirthdayModel.m
//  YKBirthdayDemo
//
//  Created by zhaojijin on 2017/9/30.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import "YKBirthdayModel.h"
#import "YKBirthdayFriendsItem.h"

@implementation YKBirthdayModel

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"friendsBirthdayInfo" : [YKBirthdayFriendsItem class]};
}

@end
