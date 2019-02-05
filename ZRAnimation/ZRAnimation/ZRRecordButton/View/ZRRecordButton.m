//
//  ZRRecordButton.m
//  ZRAnimation
//
//  Created by zhaojijin on 2018/12/5.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import "ZRRecordButton.h"

@interface ZRRecordButton()

@property (nonatomic, strong) UIButton *recordButton;
@property (nonatomic, assign) CGFloat timeInterval;
@property (nonatomic, assign) CGFloat width;

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;

@end

static CGFloat const kWhiteBorderWidth = 4;
static CGFloat const kClearBorderWidth = 3;
static CGFloat const kAnimationDuration = 0.35;
static CGFloat const kClickTimeInterval = 0.5;
static CGFloat const kHighlightTimeInterval = 0.1;

@implementation ZRRecordButton

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.width == 0) {
        self.width = self.bounds.size.width - 1;
        CGFloat recordViewXY = kWhiteBorderWidth + kClearBorderWidth;
        CGFloat recordViewWidth = self.width - recordViewXY *2;
        self.recordButton.frame = CGRectMake(recordViewXY, recordViewXY, recordViewWidth, recordViewWidth);
        self.recordButton.layer.cornerRadius = recordViewWidth/2;
    }
}

- (void)drawRect:(CGRect)rect {
    
    CGFloat radius = (self.width - kWhiteBorderWidth) * 0.5;
    CGPoint center = CGPointMake(self.width * 0.5, self.width * 0.5);
    CGFloat startAngle = M_PI * 1.5;
    UIBezierPath *backgroundPath = [self getBezierPath];
    [[UIColor whiteColor] set];
    [backgroundPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:startAngle + M_PI * 2  clockwise:YES];
    [backgroundPath stroke];
    
    UIBezierPath *progressPath = [self getBezierPath];
    [[UIColor redColor] set];
    [progressPath addArcWithCenter:center radius:radius startAngle:startAngle endAngle:startAngle + M_PI * 2 * _progress clockwise:YES];
    [progressPath stroke];
}

- (UIBezierPath *)getBezierPath {
    UIBezierPath *bezierPath = [[UIBezierPath alloc] init];
    bezierPath.lineWidth = kWhiteBorderWidth;
    return bezierPath;
}

#pragma mark - Event

- (void)setupSubviews {
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.selected = NO;
    self.timeInterval = 0;
    [self addRecordGesture];
}

- (void)addRecordGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(recordTapGesture:)];
    [self addGestureRecognizer:tap];
}

- (void)recordTapGesture:(UITapGestureRecognizer *)tap {
    CGFloat time = CFAbsoluteTimeGetCurrent();
    if ((time - self.timeInterval) < kClickTimeInterval) {
        return;
    } else {
        self.timeInterval = time;
    }
    self.selected = !self.selected;
    if (self.target && self.selector) {
        NSMethodSignature *methodSignature = [self.target methodSignatureForSelector:self.selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
        invocation.target = self.target;
        invocation.selector = self.selector;
        [invocation invoke];
    }
}

- (void)animationForDefault {
    [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:1 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.recordButton.selected = NO;
        if (self.recordButton.currentBackgroundImage) {
            self.recordButton.layer.cornerRadius = 0;
        } else {
            self.recordButton.layer.cornerRadius = self.recordButton.bounds.size.width/2;
        }
        self.recordButton.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)animationForRecording {
    [UIView animateWithDuration:kAnimationDuration delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.recordButton.selected = YES;
        if (self.recordButton.currentBackgroundImage) {
            self.recordButton.layer.cornerRadius = 0;
        } else {
            self.recordButton.layer.cornerRadius = self.recordButton.bounds.size.width/10;
        }
        self.recordButton.transform = CGAffineTransformMakeScale(0.5, 0.5);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)addTarget:(id)target selector:(SEL)selector {
    self.target = target;
    self.selector = selector;
}

- (void)setButtonBgImage:(nullable UIImage *)image forState:(UIControlState)state {
    if (!image) {
        if (state == UIControlStateNormal) {
            image = [UIImage imageNamed:@"video_record"];
        } else if (state == UIControlStateSelected) {
            image = [UIImage imageNamed:@"video_record_recording"];
        }
    }
    if (image) {
        [self.recordButton setBackgroundImage:image forState:state];
        self.recordButton.backgroundColor = [UIColor clearColor];
    }
}

#pragma mark - touches

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:kHighlightTimeInterval animations:^{
        self.recordButton.alpha = 0.8;
    }];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:kHighlightTimeInterval animations:^{
        self.recordButton.alpha = 0.8;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:kHighlightTimeInterval animations:^{
        self.recordButton.alpha = 1;
    }];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [UIView animateWithDuration:kHighlightTimeInterval animations:^{
        self.recordButton.alpha = 1;
    }];
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event {
    if ([self pointInside:point withEvent:event]) {
        return self;
    } else {
        return [super hitTest:point withEvent:event];
    }
}

#pragma mark - setter

- (void)setSelected:(BOOL)selected {
    if (selected) {
        [self animationForRecording];
    } else {
        [self animationForDefault];
    }
    _selected = selected;
}

- (void)setProgress:(CGFloat)progress {
    CGFloat pro = MAX(0, progress);
    pro = MIN(1, pro);
    _progress = progress;
    [self setNeedsDisplay];
}

- (void)setButtonColor:(UIColor *)buttonColor {
    _buttonColor = buttonColor;
    if (!self.recordButton.currentBackgroundImage) {
        self.recordButton.backgroundColor = buttonColor;
    }
}

#pragma mark - getter

- (UIButton *)recordButton {
    if (!_recordButton) {
        _recordButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _recordButton.backgroundColor = [UIColor redColor];
        _recordButton.layer.masksToBounds = YES;
        [self addSubview:_recordButton];
    }
    return _recordButton;
}

@end
