//
//  ZRMitreView.h
//  ZRAnimation
//
//  Created by zhaojijin on 2019/11/28.
//  Copyright © 2019 RobinZhao. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZRMitreView : UIView

- (void)updateProgress:(CGFloat)progress fallColor:(UIColor *)fallColor raiseColor:(UIColor *)raiseColor animaiton:(BOOL)isAnimation;

@end

NS_ASSUME_NONNULL_END
