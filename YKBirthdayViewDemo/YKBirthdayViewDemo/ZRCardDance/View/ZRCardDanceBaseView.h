//
//  ZRCardDanceBaseView.h
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/10/9.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>

#define buttonWH 20
#define buttonMargin 4

@interface ZRCardDanceBaseView : UIView

@property (nonatomic, copy) void(^clickBlock)();

- (void)showInView:(UIView *)view;
- (void)createdButton:(CGRect)frame imageName:(NSString *)imageName;

@end

