//
//  YKBirthdayView.m
//  birthdayAnimation
//
//  Created by zhaojijin on 2016/11/17.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import "YKBirthdayView.h"
#import "YKAudioPlayerMgr.h"

@interface YKBirthdayView () <CAAnimationDelegate>

@property (nonatomic, assign, readwrite) CGFloat height;
@property (nonatomic, assign, readwrite) CGFloat width;

@property (nonatomic, strong) CALayer *birthdayBodyLayer; // 盒子
@property (nonatomic, strong) CALayer *birthdayBodyFrontLayer; // 盒子
@property (nonatomic, strong) CALayer *birthdayLidLayer;  // 盒盖
@property (nonatomic, strong) CALayer *birthdayHeartLayer;// 心
@property (nonatomic, strong) CALayer *happyBirthdayLayer;// 生日快来四个字
@property (nonatomic, strong) CALayer *blingBlingLayer;   // 花絮

@property (nonatomic, strong) CALayer *musicNoteLeftLayer; // 音符
@property (nonatomic, strong) CALayer *musicNoteRightOneLayer;
@property (nonatomic, strong) CALayer *musicNoteRightTwoLayer;

@property (nonatomic, strong) UIImage *birthdayBodyImage;
@property (nonatomic, strong) UIImage *birthdayBodyFrontImage;
@property (nonatomic, strong) UIImage *birthdayLidImage;
@property (nonatomic, strong) UIImage *birthdayHeartImage;
@property (nonatomic, strong) UIImage *happyBirthdayImage;
@property (nonatomic, strong) UIImage *blingBlingImage;
@property (nonatomic, strong) UIImage *buttonNormalImage;
@property (nonatomic, strong) UIImage *buttonSelectedImage;
@property (nonatomic, strong) UIImage *musicNoteImage;
@property (nonatomic, strong) UIImage *musicNoteBlurryImage;

@property (nonatomic, assign) CGPoint bodyCenterPoint;
@property (nonatomic, assign) CGFloat bodyRadius;

@property (nonatomic, assign) CGFloat uiScale;

@property (nonatomic, strong) CAMediaTimingFunction* animationTimingFunction;

@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *birthdayTitleLabel;
@property (nonatomic, strong) UILabel *birthdaySubTitleLabel;
@property (nonatomic, strong) UILabel *birthdayDescriptionLabel;

@property (nonatomic, strong) UIButton *receiveButton;

@property (nonatomic, strong) NSMutableArray *animationList;

@end

static NSTimeInterval const KYKBirthdayAnimationDuriation = 1.0f;
static NSTimeInterval const KYKMusicGroupAnimationDuriation = 3.0f;
static NSTimeInterval const KYKBirthdayDelayDuriation = 1.8f;
static NSTimeInterval const KYKMusicOpacityDuriation = 0.5f;

static NSString *const YKBirthdayAnimationIdentifier = @"YKBirthdayAnimationIdentifier";

static inline CGFloat YKDegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;}

@implementation YKBirthdayView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setLayerFrame];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setLayerFrame];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setLayerFrame];
    }
    return self;
}

- (void)setLayerFrame {
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    if (screenWidth > 320.0f) {
        self.uiScale = 1.0f;
    } else {
        self.uiScale = 0.9f;
    }
    self.animationList = [NSMutableArray array];
    self.width = self.birthdayHeartImage.size.width * self.uiScale;
    CGFloat heartHeight = self.birthdayHeartImage.size.height * self.uiScale;
    CGRect defaultFrame = CGRectMake(self.width/2, heartHeight, 0, 0);
    CGPoint defaultAnchorPoint = CGPointMake(0.5, 1);
    
    self.birthdayHeartLayer.anchorPoint = defaultAnchorPoint;
    self.birthdayHeartLayer.frame = defaultFrame;
    
    CGFloat lidWidth = self.birthdayLidImage.size.width * self.uiScale;
    CGFloat lidHeight = self.birthdayLidImage.size.height * self.uiScale;
    CGFloat lidOriginX = self.width/2 - lidWidth/2;
    CGFloat lidOriginY = heartHeight-54 * self.uiScale;
    self.birthdayLidLayer.frame = CGRectMake(lidOriginX, lidOriginY, lidWidth, lidHeight);
    
    self.happyBirthdayLayer.anchorPoint = defaultAnchorPoint;
    self.happyBirthdayLayer.frame = defaultFrame;
    
    self.blingBlingLayer.anchorPoint = defaultAnchorPoint;
    self.blingBlingLayer.frame = defaultFrame;
    
    CGFloat bodyWidth = self.birthdayBodyImage.size.width * self.uiScale;
    CGFloat bodyHeight = self.birthdayBodyImage.size.height * self.uiScale;
    self.birthdayBodyLayer.frame = CGRectMake(lidOriginX, CGRectGetMaxY(self.birthdayLidLayer.frame)-22, bodyWidth, bodyHeight);
    
    self.birthdayBodyFrontLayer.frame = self.birthdayBodyLayer.frame;
    
    self.height = CGRectGetMaxY(self.birthdayBodyLayer.frame);
    
    self.bodyCenterPoint = CGPointMake(self.width/2, self.birthdayBodyLayer.frame.origin.y + bodyHeight/2 - 8);
    self.bodyRadius = bodyHeight/2;

    CGFloat birthdayHeartHeight = self.birthdayHeartImage.size.height * self.uiScale;
    CGFloat musicW = self.musicNoteImage.size.width *self.uiScale;
    CGFloat musicH = self.musicNoteImage.size.height *self.uiScale;
    CGRect musicOrginFrame = CGRectMake((self.width-musicW)/2, birthdayHeartHeight, musicW, musicH);
    
    // 音符起始位置
    self.musicNoteLeftLayer.frame = musicOrginFrame;
    self.musicNoteRightOneLayer.frame = musicOrginFrame;
    self.musicNoteRightTwoLayer.frame = musicOrginFrame;
    
    //音符旋转
    CGAffineTransform transform= CGAffineTransformMakeRotation(YKDegreesToRadians(-90));
    CATransform3D transform3D = CATransform3DMakeAffineTransform(transform);
    self.musicNoteLeftLayer.transform = transform3D;
    
    // 添加layer
    [self.layer addSublayer:self.birthdayBodyLayer];
    [self.layer addSublayer:self.birthdayHeartLayer];
    [self.layer addSublayer:self.happyBirthdayLayer];
    [self.layer addSublayer:self.blingBlingLayer];
    
    [self configContainView:heartHeight];
    
    [self.layer addSublayer:self.musicNoteLeftLayer];
    [self.layer addSublayer:self.musicNoteRightOneLayer];
    [self.layer addSublayer:self.musicNoteRightTwoLayer];
    [self.layer addSublayer:self.birthdayBodyFrontLayer];
    [self.layer addSublayer:self.birthdayLidLayer];
}

- (void)configContainView:(CGFloat)height {
    self.containView.frame = CGRectMake(0, 0, self.width, height);
    [self addSubview:self.containView];
    
    CGFloat labelHeight = 20;
    
    CGFloat titleOriginY = 55 * self.uiScale;
    if ([UIScreen mainScreen].bounds.size.width == 320) {
        titleOriginY = 43;
    }
    CGRect titleFrame = CGRectMake(0, titleOriginY, self.width, labelHeight);
    self.birthdayTitleLabel = [self getLabel:titleFrame text:self.birthdayTitle];
    [self.containView addSubview:self.birthdayTitleLabel];
    
    CGRect subTitleFrame = CGRectMake(0, CGRectGetMaxY(self.birthdayTitleLabel.frame), self.width, labelHeight);
    self.birthdaySubTitleLabel = [self getLabel:subTitleFrame text:self.birthdaySubTitle];
    [self.containView addSubview:self.birthdaySubTitleLabel];
    
    CGRect descriptionFrame = CGRectMake(0, CGRectGetMaxY(self.birthdaySubTitleLabel.frame), self.width, labelHeight);
    self.birthdayDescriptionLabel = [self getLabel:descriptionFrame text:self.birthdayDescritpion];
    [self.containView addSubview:self.birthdayDescriptionLabel];

    CGFloat receiveButtonW = self.buttonSelectedImage.size.width * self.uiScale;
    CGFloat receiveButtonH = self.buttonSelectedImage.size.height * self.uiScale;
    UIButton *receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    receiveButton.frame = CGRectMake(0, 0, receiveButtonW, receiveButtonH);
    receiveButton.center = CGPointMake(self.width/2, CGRectGetMaxY(self.birthdayDescriptionLabel.frame)+receiveButtonH/2 + 10*self.uiScale);
    [receiveButton setImage:self.buttonNormalImage forState:UIControlStateNormal];
    [receiveButton setImage:self.buttonSelectedImage forState:UIControlStateSelected];
    [receiveButton setImage:self.buttonSelectedImage forState:UIControlStateHighlighted];
    [receiveButton addTarget:self action:@selector(receiveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    receiveButton.alpha = 0;
    self.receiveButton = receiveButton;
    [self.containView addSubview:receiveButton];
}

- (UILabel *)getLabel:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [self colorWithValue:0xffc30228];
    label.textAlignment = NSTextAlignmentCenter;
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:12];
    label.text = text;
    return label;
}

- (CALayer *)getLayer:(UIImage *)image {
    CALayer *layer = [CALayer layer];
    [layer setContents:(id)image.CGImage];
    return layer;
}

- (void)receiveButtonAction:(id)sender {
    
    if (self.receiveActionBlock) {
        self.receiveActionBlock();
    }
}

#pragma mark - animationEvent

- (void)animationForBirthdayHeart {
    
    CGFloat heartHeight = self.birthdayHeartImage.size.height * self.uiScale;
    CGRect topLayerFrame = CGRectMake(0, 0, self.width, heartHeight);
    self.birthdayHeartLayer.frame = topLayerFrame;
    self.happyBirthdayLayer.frame = topLayerFrame;
    self.blingBlingLayer.frame = topLayerFrame;
    
    CABasicAnimation *birthdayHeartAnimation = [self getHappyBirthdayAnimation];
    [self.birthdayHeartLayer addAnimation:birthdayHeartAnimation forKey:@"birthdayHeart"];
    [self.animationList addObject:birthdayHeartAnimation];
    
    CABasicAnimation *happyBirthdayAnimation = [self getHappyBirthdayAnimation];
    happyBirthdayAnimation.delegate = self;
    [happyBirthdayAnimation setValue:@(YKBirthdayAnimationTypeHappyBirthdayShow) forKey:YKBirthdayAnimationIdentifier];
    [self.animationList addObject:happyBirthdayAnimation];
    [self.happyBirthdayLayer addAnimation:happyBirthdayAnimation forKey:@"happyBirthday"];
    
    CABasicAnimation *blingBlingAnimation = [self getHappyBirthdayAnimation];
    [self.blingBlingLayer addAnimation:blingBlingAnimation forKey:@"blingBling"];
    [self.animationList addObject:blingBlingAnimation];
}

- (CABasicAnimation *)getHappyBirthdayAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = KYKBirthdayAnimationDuriation;
    animation.repeatCount = 1;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}

// 三个音符的动画
- (void)animationForBirthdayMusic {

    CGFloat birthdayHeartHeight = self.birthdayHeartImage.size.height * self.uiScale;
    
    CGFloat musicW = self.musicNoteImage.size.width *self.uiScale;
    CGFloat musicH = self.musicNoteImage.size.height *self.uiScale;
    
    CGPoint originPoint = CGPointMake(self.width/2, birthdayHeartHeight + musicH/2);
    
    CGPoint leftEndPoint = CGPointMake(40 *self.uiScale + musicW/2, -70 *self.uiScale + musicH/2);
    CGPoint rightOneEndPoint = CGPointMake(168 *self.uiScale + musicW/2, -120 *self.uiScale + musicH/2);
    CGPoint rightTwoEndPoint = CGPointMake(275 *self.uiScale + musicW/2, -19 *self.uiScale + musicH/2);
    
    // leftMusicNotePath
    UIBezierPath *leftPath = [UIBezierPath bezierPath];
    [leftPath moveToPoint:originPoint];
    CGPoint leftControlPoint1 = CGPointMake(-10, self.height - 100);
    CGPoint leftControlPoint2 = CGPointMake(0, 0);
    [leftPath addCurveToPoint:leftEndPoint controlPoint1:leftControlPoint1 controlPoint2:leftControlPoint2];
    [self animationForBirthdayMusicAnimation:leftPath layer:self.musicNoteLeftLayer];
    
    // rightOneMusicNotePath
    UIBezierPath *rightOnePath = [UIBezierPath bezierPath];
    [rightOnePath moveToPoint:originPoint];
    CGPoint rightOneControlPoint1 = CGPointMake(self.width*3/2, -self.height/3);
    CGPoint rightOneControlPoint2 = CGPointMake(0, self.height/2);
    [rightOnePath addCurveToPoint:rightOneEndPoint controlPoint1:rightOneControlPoint1 controlPoint2:rightOneControlPoint2];
    [self animationForBirthdayMusicAnimation:rightOnePath layer:self.musicNoteRightOneLayer];
    
    // rightTwoMusicNotePath
    UIBezierPath *rightTwoPath = [UIBezierPath bezierPath];
    [rightTwoPath moveToPoint:originPoint];
    CGPoint rightTwoControlPoint1 = CGPointMake(self.width, self.height/2);
    CGPoint rightTwoControlPoint2 = CGPointMake(self.width*2/3, self.height/5);
    [rightTwoPath addCurveToPoint:rightTwoEndPoint controlPoint1:rightTwoControlPoint1 controlPoint2:rightTwoControlPoint2];
    [self animationForBirthdayMusicAnimation:rightTwoPath layer:self.musicNoteRightTwoLayer];
}

- (void)animationForBirthdayMusicAnimation:(UIBezierPath *)bezierPath layer:(CALayer *)layer {
    // 音符位置变化
    CAKeyframeAnimation *musicAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    musicAnimation.path = bezierPath.CGPath;
    musicAnimation.removedOnCompletion = NO;
    musicAnimation.repeatCount = MAXFLOAT;
    musicAnimation.fillMode = kCAFillModeForwards;
    musicAnimation.duration = KYKMusicGroupAnimationDuriation;
    musicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.animationList addObject:musicAnimation];
    
    // 音符透明度变化
    CABasicAnimation *musicOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    musicOpacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    musicOpacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    musicOpacityAnimation.duration = KYKMusicOpacityDuriation;
    musicOpacityAnimation.beginTime = KYKMusicGroupAnimationDuriation-KYKMusicOpacityDuriation;
    musicOpacityAnimation.repeatCount = MAXFLOAT;
    musicOpacityAnimation.removedOnCompletion = NO;
    musicOpacityAnimation.fillMode = kCAFillModeForwards;
    musicOpacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.animationList addObject:musicOpacityAnimation];
    
    // 音符组动画
    CAAnimationGroup * musicGroupAnimation = [CAAnimationGroup animation];
    musicGroupAnimation.animations = @[musicAnimation,musicOpacityAnimation];
    musicGroupAnimation.duration = KYKMusicGroupAnimationDuriation;
    musicGroupAnimation.removedOnCompletion = NO;
    musicGroupAnimation.repeatCount = MAXFLOAT;
    musicGroupAnimation.fillMode = kCAFillModeForwards;
    musicGroupAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
    [self.animationList addObject:musicGroupAnimation];
    [layer addAnimation:musicGroupAnimation forKey:@"musicGroupAnimation"];
}

// 盒子打开动画
- (void)animationForBirthdayLid {
    // 动画开始播放音乐
    [[YKAudioPlayerMgr sharedInstance] playMusic:@"birthday.mp3" isLoops:YES];
    
    // 盒子打开动画路径
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *timingFunctions = [NSMutableArray array];
    UIBezierPath *strokePath = [UIBezierPath bezierPath];
    for (NSInteger i = 1; i < 35; i++) {
        if (i < 30) {
            [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-i, self.bodyCenterPoint.y - i/15.0) radius:self.bodyRadius startAngle:YKDegreesToRadians(-90-(i-1)) endAngle:YKDegreesToRadians(-90-i) clockwise:NO];
        } else {
            [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-31 *self.uiScale, self.bodyCenterPoint.y-2 *self.uiScale) radius:self.bodyRadius startAngle:YKDegreesToRadians(-90-(i-1)) endAngle:YKDegreesToRadians(-90-i) clockwise:NO];
        }
    }
    for (NSInteger i = 1; i < 17; i++) {
        [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-31 *self.uiScale, self.bodyCenterPoint.y-2 *self.uiScale) radius:self.bodyRadius  startAngle:YKDegreesToRadians(-124-(i-1)) endAngle:YKDegreesToRadians(-124-i) clockwise:NO];
    }
    for (NSInteger i = 1; i < 5; i++) {
        [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-31 *self.uiScale, self.bodyCenterPoint.y-2 *self.uiScale) radius:self.bodyRadius startAngle:YKDegreesToRadians(-140 + (i-1)) endAngle:YKDegreesToRadians(-140 + i) clockwise:YES];
    }
    for (NSInteger i = 0; i < 6; i++) {
        [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-31 *self.uiScale, self.bodyCenterPoint.y-2 *self.uiScale) radius:self.bodyRadius-3 *self.uiScale startAngle:YKDegreesToRadians(-140-(i-1)) endAngle:YKDegreesToRadians(-140-i) clockwise:NO];
    }
   for (NSInteger i = 1; i < 40; i++) {
        [values addObject:@(YKDegreesToRadians(-i))];
        [timingFunctions addObject:self.animationTimingFunction];
    }
    // 路径
    CAKeyframeAnimation *lidAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    lidAnimation.path = strokePath.CGPath;
    lidAnimation.removedOnCompletion = NO;
    lidAnimation.fillMode = kCAFillModeForwards;
    lidAnimation.duration = KYKBirthdayAnimationDuriation;
    lidAnimation.timingFunction = self.animationTimingFunction;
    [self.animationList addObject:lidAnimation];
    
    // 旋转
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = KYKBirthdayAnimationDuriation;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.values = values;
    rotationAnimation.timingFunctions = timingFunctions;
    [self.animationList addObject:rotationAnimation];
    
    // group
    CAAnimationGroup * birthdayLidAnimationGroup = [CAAnimationGroup animation];
    birthdayLidAnimationGroup.animations = @[lidAnimation,rotationAnimation];
    birthdayLidAnimationGroup.duration = KYKBirthdayAnimationDuriation;
    birthdayLidAnimationGroup.delegate = self;
    birthdayLidAnimationGroup.removedOnCompletion = NO;
    birthdayLidAnimationGroup.fillMode = kCAFillModeForwards;
    birthdayLidAnimationGroup.timingFunction = self.animationTimingFunction;
    [birthdayLidAnimationGroup setValue:@(YKBirthdayAnimationTypeLidGroup) forKey:YKBirthdayAnimationIdentifier];
    [self.animationList addObject:birthdayLidAnimationGroup];
    [self.birthdayLidLayer addAnimation:birthdayLidAnimationGroup forKey:@"birthdayLidAnimation"];
}

// 带happyBirthday字体的layer透明度渐变为0
- (void)animationForHappyBirthdayOpacity {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = KYKBirthdayDelayDuriation;
    opacityAnimation.beginTime = KYKBirthdayAnimationDuriation;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    [self.animationList addObject:opacityAnimation];
    
    CAAnimationGroup * opacityAnimationGroup = [CAAnimationGroup animation];
    opacityAnimationGroup.animations = @[opacityAnimation];
    opacityAnimationGroup.duration = KYKBirthdayDelayDuriation +KYKBirthdayAnimationDuriation;
    opacityAnimationGroup.delegate = self;
    opacityAnimationGroup.removedOnCompletion = NO;
    opacityAnimationGroup.fillMode = kCAFillModeForwards;
    opacityAnimationGroup.timingFunction = self.animationTimingFunction;
    [opacityAnimationGroup setValue:@(YKBirthdayAnimationTypeHappyBirthdayHidden) forKey:YKBirthdayAnimationIdentifier];
    [self.animationList addObject:opacityAnimationGroup];
    [self.happyBirthdayLayer addAnimation:opacityAnimationGroup forKey:@"happyBirthdayHidden"];
}

// 显示用户相关文字和立即领取按钮显示动画
- (void)animationForContainView {
    [UIView animateWithDuration:0.5 animations:^{
        self.containView.alpha = 1.f;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.5 animations:^{
            self.receiveButton.alpha = 1.f;
        }];
    }];
}

#pragma mark - color

- (UIColor *)colorWithValue:(NSUInteger)colorValue {
    
    CGFloat red = ((colorValue & 0x00FF0000) >> 16) / 255.0;
    
    CGFloat green = ((colorValue & 0x0000FF00) >> 8) / 255.0;
    
    CGFloat blue = (colorValue & 0x000000FF) / 255.0;
    
    CGFloat alpha = ((colorValue & 0xFF000000) >> 24) / 255.0;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

#pragma mark - animationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSInteger keyPath = [[anim valueForKey:YKBirthdayAnimationIdentifier] integerValue];
    if (YKBirthdayAnimationTypeLidGroup == keyPath) {
        [self animationForBirthdayHeart];
        [self animationForBirthdayMusic];
    } else if (YKBirthdayAnimationTypeHappyBirthdayShow == keyPath) {
        [self animationForHappyBirthdayOpacity];
    } else if (YKBirthdayAnimationTypeHappyBirthdayHidden == keyPath) {
        [self animationForContainView];
    }
}

#pragma  mark - setter

- (void)setBirthdayTitle:(NSString *)birthdayTitle {
    _birthdayTitle = birthdayTitle;
    self.birthdayTitleLabel.text = _birthdayTitle;
}

- (void)setBirthdaySubTitle:(NSString *)birthdaySubTitle {
    _birthdaySubTitle = birthdaySubTitle;
    self.birthdaySubTitleLabel.text = _birthdaySubTitle;
}

- (void)setBirthdayDescritpion:(NSString *)birthdayDescritpion {
    _birthdayDescritpion = birthdayDescritpion;
    self.birthdayDescriptionLabel.text = _birthdayDescritpion;
}

// 清除动画
- (void)setIsCloseAnimation:(BOOL)isCloseAnimation {
    _isCloseAnimation = isCloseAnimation;
    if (isCloseAnimation) {
        [self removeAnimation];
        [self.containView removeFromSuperview];
        self.containView = nil;
    }
}

- (void)removeAnimation {
    NSMutableArray * animationArray = [NSMutableArray arrayWithArray:self.animationList];
    for (NSInteger i = 0; i < animationArray.count; i++) {
        CAAnimation * anim = self.animationList[i];
        anim.removedOnCompletion = YES;
        anim.delegate = nil;
        anim = nil;
    }
    [self removeFromSupperLayer:self.birthdayLidLayer];
    [self removeFromSupperLayer:self.birthdayBodyFrontLayer];
    [self removeFromSupperLayer:self.musicNoteRightTwoLayer];
    [self removeFromSupperLayer:self.musicNoteRightOneLayer];
    [self removeFromSupperLayer:self.musicNoteLeftLayer];
    [self removeFromSupperLayer:self.blingBlingLayer];
    [self removeFromSupperLayer:self.happyBirthdayLayer];
    [self removeFromSupperLayer:self.birthdayHeartLayer];
    [self removeFromSupperLayer:self.birthdayBodyLayer];
}

- (void)removeFromSupperLayer:(CALayer *)subLayer {
    [subLayer removeAllAnimations];
    [subLayer removeFromSuperlayer];
    subLayer = nil;
}

#pragma mark - getter

- (UIImage *)birthdayHeartImage {
    if (nil == _birthdayHeartImage) {
        _birthdayHeartImage = [UIImage imageNamed:@"birthday_heart"];
    }
    return _birthdayHeartImage;
}

- (UIImage *)birthdayBodyImage {
    if (nil == _birthdayBodyImage) {
        _birthdayBodyImage = [UIImage imageNamed:@"birthday_body"];
    }
    return _birthdayBodyImage;
}

- (UIImage *)birthdayBodyFrontImage {
    if (nil == _birthdayBodyFrontImage) {
        _birthdayBodyFrontImage = [UIImage imageNamed:@"birthday_body_front"];
    }
    return _birthdayBodyFrontImage;
}

- (UIImage *)birthdayLidImage {
    if (nil == _birthdayLidImage) {
        _birthdayLidImage = [UIImage imageNamed:@"birthday_lid"];
    }
    return _birthdayLidImage;
}

- (UIImage *)happyBirthdayImage {
    if (nil == _happyBirthdayImage) {
        _happyBirthdayImage = [UIImage imageNamed:@"birthday_happyBirthday"];
    }
    return _happyBirthdayImage;
}

- (UIImage *)blingBlingImage {
    if (nil == _blingBlingImage) {
        _blingBlingImage = [UIImage imageNamed:@"birthday_blingbling"];
    }
    return _blingBlingImage;
}

- (UIImage *)buttonNormalImage {
    if (nil == _buttonNormalImage) {
        _buttonNormalImage = [UIImage imageNamed:@"birthday_btn_normal"];
    }
    return _buttonNormalImage;
}

- (UIImage *)buttonSelectedImage {
    if (nil == _buttonSelectedImage) {
        _buttonSelectedImage = [UIImage imageNamed:@"birthday_btn_press"];
    }
    return _buttonSelectedImage;
}

- (UIImage *)musicNoteImage {
    if (nil == _musicNoteImage) {
        _musicNoteImage = [UIImage imageNamed:@"birthday_music"];
    }
    return _musicNoteImage;
}

- (UIImage *)musicNoteBlurryImage {
    if (nil == _musicNoteBlurryImage) {
        _musicNoteBlurryImage = [UIImage imageNamed:@"birthday_music_blurry"];
    }
    return _musicNoteBlurryImage;
}

- (CALayer *)birthdayBodyLayer {
    if (nil == _birthdayBodyLayer) {
        _birthdayBodyLayer = [self getLayer:self.birthdayBodyImage];
    }
    return _birthdayBodyLayer;
}

- (CALayer *)birthdayBodyFrontLayer {
    if (nil == _birthdayBodyFrontLayer) {
        _birthdayBodyFrontLayer = [self getLayer:self.birthdayBodyFrontImage];
    }
    return _birthdayBodyFrontLayer;
}

- (CALayer *)birthdayLidLayer {
    if (nil == _birthdayLidLayer) {
        _birthdayLidLayer = [self getLayer:self.birthdayLidImage];
    }
    return _birthdayLidLayer;
}

- (CALayer *)birthdayHeartLayer {
    if (nil == _birthdayHeartLayer) {
        _birthdayHeartLayer = [self getLayer:self.birthdayHeartImage];
    }
    return _birthdayHeartLayer;
}

- (CALayer *)happyBirthdayLayer {
    if (nil == _happyBirthdayLayer) {
        _happyBirthdayLayer = [self getLayer:self.happyBirthdayImage];
    }
    return _happyBirthdayLayer;
}

- (CALayer *)blingBlingLayer {
    if (nil == _blingBlingLayer) {
        _blingBlingLayer = [self getLayer:self.blingBlingImage];
    }
    return _blingBlingLayer;
}

- (CALayer *)musicNoteLeftLayer {
    if (nil == _musicNoteLeftLayer) {
        _musicNoteLeftLayer = [self getLayer:self.musicNoteImage];
    }
    return _musicNoteLeftLayer;
}

- (CALayer *)musicNoteRightOneLayer {
    if (nil == _musicNoteRightOneLayer) {
        _musicNoteRightOneLayer = [self getLayer:self.musicNoteBlurryImage];
    }
    return _musicNoteRightOneLayer;
}

- (CALayer *)musicNoteRightTwoLayer {
    if (nil == _musicNoteRightTwoLayer) {
        _musicNoteRightTwoLayer = [self getLayer:self.musicNoteImage];
    }
    return _musicNoteRightTwoLayer;
}

- (CAMediaTimingFunction *)animationTimingFunction {
    if (nil == _animationTimingFunction) {
        _animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    }
    return _animationTimingFunction;
}

- (UIView *)containView {
    if (nil == _containView) {
        _containView = [[UIView alloc] init];
        _containView.backgroundColor = [UIColor clearColor];
        _containView.alpha = 0;
    }
    return _containView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
