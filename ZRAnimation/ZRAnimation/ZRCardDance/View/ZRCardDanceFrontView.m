//
//  ZRCardDanceFrontView.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRCardDanceFrontView.h"

@implementation ZRCardDanceFrontView

+ (ZRCardDanceFrontView *)createdWithFrame:(CGRect)frame {
    ZRCardDanceFrontView *view = [[ZRCardDanceFrontView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor whiteColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 4;
    return view;
}

- (void)setupSubViews:(CGRect)frame model:(ZRCardDanceModel *)model {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    imageView.image = [UIImage imageNamed:@"coin_card_front"];
    [self addSubview:imageView];
    [self createdButton:CGRectMake(self.bounds.size.width - buttonWH - buttonMargin, buttonMargin, buttonWH, buttonWH) imageName:@"icon_front_button"];
}

@end
