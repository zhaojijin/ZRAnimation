//
//  ZRRecordButton.h
//  ZRAnimation
//
//  Created by zhaojijin on 2018/12/5.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZRRecordButton : UIView

/** 设置中间按钮的颜色，默认红色 */
@property (nonatomic, strong) UIColor *buttonColor;
/** 默认是NO */
@property (nonatomic, assign) BOOL selected;
/** 圆形进度条，默认不显示 */
@property (nonatomic, assign) CGFloat progress;

- (void)addTarget:(id)target selector:(SEL)selector;
/** 设置中间按钮常规图片，不设置默认显示buttonColor */
- (void)setButtonBgImage:(nullable UIImage *)image forState:(UIControlState)state;
- (instancetype)init NS_UNAVAILABLE;

@end
