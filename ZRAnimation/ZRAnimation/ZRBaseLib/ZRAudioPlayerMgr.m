//
//  ZRAudioPlayerMgr.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRAudioPlayerMgr.h"
#import <AVFoundation/AVFoundation.h>

@interface ZRAudioPlayerMgr ()<AVAudioPlayerDelegate>

@end

@implementation ZRAudioPlayerMgr

static ZRAudioPlayerMgr *sharedAudioPlayerMgr = nil;

+ (ZRAudioPlayerMgr *)sharedInstance {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedAudioPlayerMgr = [[ZRAudioPlayerMgr alloc] init];
    });
    
    return sharedAudioPlayerMgr;
}

/**
 *  存放所有的音乐播放器
 */
static NSMutableDictionary *musicPlayers;

- (NSMutableDictionary *)musicPlayers {
    if (!musicPlayers) {
        musicPlayers = [NSMutableDictionary dictionary];
    }
    return musicPlayers;
}

/**
 *  播放音乐
 *
 *  @param filename 音乐的文件名
 */
- (BOOL)playMusic:(NSString *)filename isLoops:(BOOL)isLoops {
    if (!filename) return NO;
    
    AVAudioPlayer *player = [self musicPlayers][filename];
    if (!player) {
        
        NSURL *url = [[NSBundle mainBundle] URLForResource:filename withExtension:nil];
        if (!url) return NO;
        
        player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        player.delegate = self;
        
        if (isLoops) {
            player.numberOfLoops = -1;
        }
        if (![player prepareToPlay]) return NO;
        
        [self musicPlayers][filename] = player;
    }
    
    if (!player.isPlaying) {
        return [player play];
    }
    return YES;
}

- (void)stopMusic:(NSString *)filename {
    if (filename == nil || filename.length == 0)  return;
    AVAudioPlayer *player = [self musicPlayers][filename];
    if (player) {
        [player stop];
        [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
        [[self musicPlayers] removeObjectForKey:filename];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    [[AVAudioSession sharedInstance] setActive:NO withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:nil];
}

@end
