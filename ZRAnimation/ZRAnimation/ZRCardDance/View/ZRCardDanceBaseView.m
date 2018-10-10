//
//  ZRCardDanceBaseView.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRCardDanceBaseView.h"

@implementation ZRCardDanceBaseView

- (void)createdButton:(CGRect)frame imageName:(NSString *)imageName {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 4;
    if (imageName) {
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateSelected];
    }
    [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
}

- (void)clickAction:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock();
    }
}

- (void)showInView:(UIView *)view {
    [view addSubview:self];
}

@end
