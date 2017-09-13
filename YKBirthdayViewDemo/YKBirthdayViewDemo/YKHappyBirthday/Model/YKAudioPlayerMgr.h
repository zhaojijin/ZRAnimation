//
//  YKAudioPlayerMgr.h
//  SimpleFinance
//
//  Created by zhaojijin on 15/8/31.
//  Copyright (c) 2015年 yinker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YKAudioPlayerMgr : NSObject

+ (YKAudioPlayerMgr *)sharedInstance;

/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
- (BOOL)playMusic:(NSString *)filename isLoops:(BOOL)isLoops;

- (void)stopMusic:(NSString *)filename;

@end
