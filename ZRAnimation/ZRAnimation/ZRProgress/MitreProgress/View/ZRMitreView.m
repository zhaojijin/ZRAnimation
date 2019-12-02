//
//  ZRMitreView.m
//  ZRAnimation
//
//  Created by zhaojijin on 2019/11/28.
//  Copyright © 2019 RobinZhao. All rights reserved.
//

#import "ZRMitreView.h"

@interface ZRMitreSubView : UIView

@property (nonatomic, strong) UIColor *color;

@end

@implementation ZRMitreSubView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    bezierPath.lineWidth = rect.size.height;
    [bezierPath moveToPoint:CGPointMake(0, 0)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width, 0)];
    [bezierPath addLineToPoint:CGPointMake(rect.size.width - rect.size.height, rect.size.height)];
    [bezierPath addLineToPoint:CGPointMake(0, rect.size.height)];
    [self.color set];
    [bezierPath addClip];
    [bezierPath stroke];
}

- (void)setColor:(UIColor *)color {
    _color = color;
    [self setNeedsDisplay];
}

@end


/********** ZRMitreView ***********/

@interface ZRMitreView()

@property (nonatomic, strong) ZRMitreSubView *mitreSubView;
@property (nonatomic, strong) UILabel *leftProgressLabel;
@property (nonatomic, strong) UILabel *rightProgressLabel;

@end

@implementation ZRMitreView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.mitreSubView = [[ZRMitreSubView alloc] init];
    [self addSubview:self.mitreSubView];
    self.leftProgressLabel = [self getLabel];
    self.leftProgressLabel.frame = CGRectMake(10, 0, 50, self.bounds.size.height);
    self.rightProgressLabel = [self getLabel];
    self.rightProgressLabel.textAlignment = NSTextAlignmentRight;
    self.rightProgressLabel.frame = CGRectMake(self.bounds.size.width - 10 - 50, 0, 50, self.bounds.size.height);
}

- (UILabel *)getLabel {
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:13];
    [self addSubview:label];
    return label;
}

- (void)updateProgress:(CGFloat)progress fallColor:(UIColor *)fallColor raiseColor:(UIColor *)raiseColor animaiton:(BOOL)isAnimation {
    self.backgroundColor = raiseColor;
    self.leftProgressLabel.text = [NSString stringWithFormat:@"%.0lf%%",progress * 100];
    self.rightProgressLabel.text = [NSString stringWithFormat:@"%.0lf%%",(1-progress) *100];
    if (isAnimation) {
        [UIView animateWithDuration:0.15 animations:^{
            [self updateMitreSubViewFrame:progress];
        }];
    } else {
        [self updateMitreSubViewFrame:progress];
    }
    NSLog(@"%@",NSStringFromCGRect(self.mitreSubView.frame));
    self.mitreSubView.color = fallColor;
}

- (void)updateMitreSubViewFrame:(CGFloat)progress {
    CGFloat width = self.bounds.size.width *progress;
    if (width <= self.bounds.size.height) {
        width = self.bounds.size.height;
    }
    self.mitreSubView.frame = CGRectMake(0, 0, width, self.bounds.size.height);
}

@end
