//
//  ZRCardDanceView.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRCardDanceView.h"
#import "ZRCardDanceFrontView.h"
#import "ZRCardDanceReverseSideView.h"

static NSTimeInterval zrCardDanceDuration = 0.5;

@interface ZRCardDanceView()

@property (nonatomic, strong) ZRCardDanceFrontView *frontView;
@property (nonatomic, strong) ZRCardDanceReverseSideView *reverseSideView;

@end

@implementation ZRCardDanceView

- (instancetype)initWithFrame:(CGRect)frame model:(ZRCardDanceModel *)model {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubViews:frame model:model];
    }
    return self;
}

- (void)setupSubViews:(CGRect)frame model:(ZRCardDanceModel *)model {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(-3, 1);
    self.layer.shadowOpacity = 0.2;
    
    CGRect rect = CGRectMake(0, 0, frame.size.width, frame.size.height);
    self.reverseSideView = [ZRCardDanceReverseSideView createdWithFrame:rect];
    [self.reverseSideView setupSubViews:rect model:model];
    __weak typeof(self) weakSelf = self;
    self.reverseSideView.clickBlock = ^{
        [weakSelf animationIsToFront:YES];
    };
    self.frontView = [ZRCardDanceFrontView createdWithFrame:rect];
    [self.frontView setupSubViews:rect model:model];
    self.frontView.clickBlock = ^{
        [weakSelf animationIsToFront:NO];
    };
    [self.frontView showInView:self];
    [self.reverseSideView showInView:self]; // 反面在上面要后添加
}

// 翻牌动画方法一
- (void)animationIsToFront:(BOOL)toFront {
    
    UIViewAnimationOptions option = toFront ?  UIViewAnimationOptionTransitionFlipFromLeft : UIViewAnimationOptionTransitionFlipFromRight;
    [UIView transitionWithView:self duration:zrCardDanceDuration options:option animations:^{
        if (toFront) {
            self.frontView.hidden = NO;
            self.reverseSideView.hidden = YES;
        } else {
            self.frontView.hidden = YES;
            self.reverseSideView.hidden = NO;
        }
    } completion:^(BOOL finished) {
        
    }];
}

// 方法二
- (void)rotateIsToFront:(BOOL)toFront {
    [UIView beginAnimations:@"aa" context:nil];
    [UIView setAnimationDuration:zrCardDanceDuration];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    if (toFront) {
        self.frontView.hidden = NO;
        self.reverseSideView.hidden = YES;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self cache:NO];
    } else {
        self.frontView.hidden = YES;
        self.reverseSideView.hidden = NO;
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self cache:NO];
    }
    
    [UIView commitAnimations];
}

@end
