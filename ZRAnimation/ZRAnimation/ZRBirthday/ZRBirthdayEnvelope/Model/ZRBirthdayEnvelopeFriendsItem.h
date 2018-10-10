//
//  ZRBirthdayEnvelopeFriendsItem.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZRBirthdayEnvelopeFriendsItem : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isMore; // 是否是省略cell 默认是NO

@end
