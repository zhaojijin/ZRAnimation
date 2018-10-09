//
//  ZRCardDanceFrontView.h
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/10/9.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import "ZRCardDanceBaseView.h"
#import "ZRCardDanceModel.h"

@interface ZRCardDanceFrontView : ZRCardDanceBaseView

+ (ZRCardDanceFrontView *)createdWithFrame:(CGRect)frame;
- (void)setupSubViews:(CGRect)frame model:(ZRCardDanceModel *)model;

@end

