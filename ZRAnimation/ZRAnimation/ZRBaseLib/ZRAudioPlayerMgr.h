//
//  ZRAudioPlayerMgr.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <Foundation/Foundation.h>

static NSString *const ZRBirthdayMusicName = @"birthday.mp3";

@interface ZRAudioPlayerMgr : NSObject

+ (ZRAudioPlayerMgr *)sharedInstance;

/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
- (BOOL)playMusic:(NSString *)filename isLoops:(BOOL)isLoops;

- (void)stopMusic:(NSString *)filename;

@end
