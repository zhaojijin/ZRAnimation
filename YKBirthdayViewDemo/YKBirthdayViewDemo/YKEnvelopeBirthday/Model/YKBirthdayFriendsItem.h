//
//  YKBirthdayFriendsItem.h
//  YKBirthdayDemo
//
//  Created by zhaojijin on 2017/10/18.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKBirthdayFriendsItem : NSObject

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, assign) BOOL isMore; // 是否是省略cell 默认是NO

@end
