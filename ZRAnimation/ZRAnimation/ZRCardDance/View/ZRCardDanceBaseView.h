//
//  ZRCardDanceBaseView.h
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define buttonWH 20
#define buttonMargin 4

@interface ZRCardDanceBaseView : UIView

@property (nonatomic, copy) void(^clickBlock)(void);

- (void)showInView:(UIView *)view;
- (void)createdButton:(CGRect)frame imageName:(NSString *)imageName;

@end
