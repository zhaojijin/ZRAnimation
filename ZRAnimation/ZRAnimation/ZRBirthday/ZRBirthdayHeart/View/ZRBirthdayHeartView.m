//
//  ZRBirthdayHeartView.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayHeartView.h"
#import "ZRAudioPlayerMgr.h"
#import "UIColor+ZRColor.h"

@interface ZRBirthdayHeartView () <CAAnimationDelegate>

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

@property (nonatomic, strong) UIImage *musicNoteImage;
@property (nonatomic, strong) UIImage *musicNoteBlurryImage;

@property (nonatomic, assign) CGPoint bodyCenterPoint;
@property (nonatomic, assign) CGFloat bodyRadius;
@property (nonatomic, assign) CGFloat uiScale;
@property (nonatomic, assign) CGFloat birthdayHeartHeight;

@property (nonatomic, strong) UIView *containView;
@property (nonatomic, strong) UILabel *birthdayTitleLabel;
@property (nonatomic, strong) UILabel *birthdaySubTitleLabel;
@property (nonatomic, strong) UILabel *birthdayDescriptionLabel;
@property (nonatomic, strong) UIButton *receiveButton;

@property (nonatomic, strong) NSMutableArray *animationList;

@property (nonatomic, strong) CAMediaTimingFunction* animationTimingFunction;

@end

static NSTimeInterval const KZRBirthdayAnimationDuriation = 1.0f;
static NSTimeInterval const KZRMusicGroupAnimationDuriation = 3.0f;
static NSTimeInterval const KZRBirthdayDelayDuriation = 1.8f;
static NSTimeInterval const KZRMusicOpacityDuriation = 0.5f;

static NSString *const ZRBirthdayAnimationIdentifier = @"ZRBirthdayAnimationIdentifier";

static inline CGFloat ZRDegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;}

@implementation ZRBirthdayHeartView

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews {
    self.animationList = [NSMutableArray array];
    self.uiScale = ZRScreenW > 320.0f ? 1.0f : 0.9f;
    [self setLayerFrame];
}

- (void)setLayerFrame {
    
    UIImage *birthdayHeartImage = [UIImage imageNamed:@"birthday_heart"];
    self.birthdayHeartHeight = birthdayHeartImage.size.height * self.uiScale;
    self.width = birthdayHeartImage.size.width * self.uiScale;
    
    UIImage *birthdayBodyImage = [UIImage imageNamed:@"birthday_heart_body"];
    UIImage *birthdayBodyFrontImage = [UIImage imageNamed:@"birthday_heart_body_front"];
    UIImage *birthdayLidImage = [UIImage imageNamed:@"birthday_heart_lid"];
    UIImage *happyBirthdayImage = [UIImage imageNamed:@"birthday_heart_happyBirthday"];
    UIImage *blingBlingImage = [UIImage imageNamed:@"birthday_heart_blingbling"];
    self.musicNoteImage = [UIImage imageNamed:@"birthday_heart_music"];
    self.musicNoteBlurryImage = [UIImage imageNamed:@"birthday_heart_music_blurry"];
    
    self.birthdayBodyLayer = [self getLayer:birthdayBodyImage];
    self.birthdayBodyFrontLayer = [self getLayer:birthdayBodyFrontImage];
    self.birthdayLidLayer = [self getLayer:birthdayLidImage];
    self.birthdayHeartLayer = [self getLayer:birthdayHeartImage];
    self.happyBirthdayLayer = [self getLayer:happyBirthdayImage];
    self.blingBlingLayer = [self getLayer:blingBlingImage];
    self.musicNoteLeftLayer = [self getLayer:self.musicNoteImage];
    self.musicNoteRightOneLayer = [self getLayer:self.musicNoteBlurryImage];
    self.musicNoteRightTwoLayer = [self getLayer:self.musicNoteImage];
    self.animationTimingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    self.containView = [[UIView alloc] init];
    self.containView.backgroundColor = [UIColor clearColor];
    self.containView.alpha = 0;
    
    CGRect defaultFrame = CGRectMake(self.width/2, self.birthdayHeartHeight, 0, 0);
    CGPoint defaultAnchorPoint = CGPointMake(0.5, 1);
    
    self.birthdayHeartLayer.anchorPoint = defaultAnchorPoint;
    self.birthdayHeartLayer.frame = defaultFrame;
    
    CGFloat lidWidth = birthdayLidImage.size.width * self.uiScale;
    CGFloat lidHeight = birthdayLidImage.size.height * self.uiScale;
    CGFloat lidOriginX = self.width/2 - lidWidth/2;
    CGFloat lidOriginY = self.birthdayHeartHeight-54 * self.uiScale;
    self.birthdayLidLayer.frame = CGRectMake(lidOriginX, lidOriginY, lidWidth, lidHeight);
    
    self.happyBirthdayLayer.anchorPoint = defaultAnchorPoint;
    self.happyBirthdayLayer.frame = defaultFrame;
    
    self.blingBlingLayer.anchorPoint = defaultAnchorPoint;
    self.blingBlingLayer.frame = defaultFrame;
    
    CGFloat bodyWidth = birthdayBodyImage.size.width * self.uiScale;
    CGFloat bodyHeight = birthdayBodyImage.size.height * self.uiScale;
    self.birthdayBodyLayer.frame = CGRectMake(lidOriginX, CGRectGetMaxY(self.birthdayLidLayer.frame)-22, bodyWidth, bodyHeight);
    
    self.birthdayBodyFrontLayer.frame = self.birthdayBodyLayer.frame;
    
    self.height = CGRectGetMaxY(self.birthdayBodyLayer.frame);
    
    self.bodyCenterPoint = CGPointMake(self.width/2, self.birthdayBodyLayer.frame.origin.y + bodyHeight/2 - 8);
    self.bodyRadius = bodyHeight/2;
    
    CGFloat musicW = self.musicNoteImage.size.width *self.uiScale;
    CGFloat musicH = self.musicNoteImage.size.height *self.uiScale;
    CGRect musicOrginFrame = CGRectMake((self.width-musicW)/2, self.birthdayHeartHeight, musicW, musicH);
    
    // 音符起始位置
    self.musicNoteLeftLayer.frame = musicOrginFrame;
    self.musicNoteRightOneLayer.frame = musicOrginFrame;
    self.musicNoteRightTwoLayer.frame = musicOrginFrame;
    
    //音符旋转
    CGAffineTransform transform= CGAffineTransformMakeRotation(ZRDegreesToRadians(-90));
    CATransform3D transform3D = CATransform3DMakeAffineTransform(transform);
    self.musicNoteLeftLayer.transform = transform3D;
    
    // 添加layer 注意顺序
    [self.layer addSublayer:self.birthdayBodyLayer];
    [self.layer addSublayer:self.birthdayHeartLayer];
    [self.layer addSublayer:self.happyBirthdayLayer];
    [self.layer addSublayer:self.blingBlingLayer];
    
    [self configContainView:self.birthdayHeartHeight];
    
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
    if (ZRScreenW == 320) {
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
    
    [self setupReceiveButton];
}

- (void)setupReceiveButton {
    UIImage *buttonNormalImage = [UIImage imageNamed:@"birthday_heart_btn_normal"];
    UIImage *buttonSelectedImage = [UIImage imageNamed:@"birthday_heart_btn_press"];
    CGFloat receiveButtonW = buttonSelectedImage.size.width * self.uiScale;
    CGFloat receiveButtonH = buttonSelectedImage.size.height * self.uiScale;
    UIButton *receiveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    receiveButton.frame = CGRectMake(0, 0, receiveButtonW, receiveButtonH);
    receiveButton.center = CGPointMake(self.width/2, CGRectGetMaxY(self.birthdayDescriptionLabel.frame)+receiveButtonH/2 + 10*self.uiScale);
    [receiveButton setImage:buttonNormalImage forState:UIControlStateNormal];
    [receiveButton setImage:buttonSelectedImage forState:UIControlStateSelected];
    [receiveButton setImage:buttonSelectedImage forState:UIControlStateHighlighted];
    [receiveButton addTarget:self action:@selector(receiveButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    receiveButton.alpha = 0;
    self.receiveButton = receiveButton;
    [self.containView addSubview:receiveButton];
}

- (UILabel *)getLabel:(CGRect)frame text:(NSString *)text {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.textColor = [UIColor zr_colorWithValue:0xffc30228];
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
    
    CGRect topLayerFrame = CGRectMake(0, 0, self.width, self.birthdayHeartHeight);
    self.birthdayHeartLayer.frame = topLayerFrame;
    self.happyBirthdayLayer.frame = topLayerFrame;
    self.blingBlingLayer.frame = topLayerFrame;
    
    CABasicAnimation *birthdayHeartAnimation = [self getHappyBirthdayAnimation];
    [self.birthdayHeartLayer addAnimation:birthdayHeartAnimation forKey:@"birthdayHeart"];
    [self.animationList addObject:birthdayHeartAnimation];
    
    CABasicAnimation *happyBirthdayAnimation = [self getHappyBirthdayAnimation];
    happyBirthdayAnimation.delegate = self;
    [happyBirthdayAnimation setValue:@(ZRBirthdayAnimationTypeHappyBirthdayShow) forKey:ZRBirthdayAnimationIdentifier];
    [self.animationList addObject:happyBirthdayAnimation];
    [self.happyBirthdayLayer addAnimation:happyBirthdayAnimation forKey:@"happyBirthday"];
    
    CABasicAnimation *blingBlingAnimation = [self getHappyBirthdayAnimation];
    [self.blingBlingLayer addAnimation:blingBlingAnimation forKey:@"blingBling"];
    [self.animationList addObject:blingBlingAnimation];
}

- (CABasicAnimation *)getHappyBirthdayAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = KZRBirthdayAnimationDuriation;
    animation.repeatCount = 1;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    return animation;
}

// 三个音符的动画
- (void)animationForBirthdayMusic {
    
    CGFloat musicW = self.musicNoteImage.size.width *self.uiScale;
    CGFloat musicH = self.musicNoteImage.size.height *self.uiScale;
    
    CGPoint originPoint = CGPointMake(self.width/2, self.birthdayHeartHeight + musicH/2);
    
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
    musicAnimation.duration = KZRMusicGroupAnimationDuriation;
    musicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.animationList addObject:musicAnimation];
    
    // 音符透明度变化
    CABasicAnimation *musicOpacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    musicOpacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    musicOpacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    musicOpacityAnimation.duration = KZRMusicOpacityDuriation;
    musicOpacityAnimation.beginTime = KZRMusicGroupAnimationDuriation-KZRMusicOpacityDuriation;
    musicOpacityAnimation.repeatCount = MAXFLOAT;
    musicOpacityAnimation.removedOnCompletion = NO;
    musicOpacityAnimation.fillMode = kCAFillModeForwards;
    musicOpacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    [self.animationList addObject:musicOpacityAnimation];
    
    // 音符组动画
    CAAnimationGroup * musicGroupAnimation = [CAAnimationGroup animation];
    musicGroupAnimation.animations = @[musicAnimation,musicOpacityAnimation];
    musicGroupAnimation.duration = KZRMusicGroupAnimationDuriation;
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
    [[ZRAudioPlayerMgr sharedInstance] playMusic:ZRBirthdayMusicName isLoops:YES];
    
    // 盒子打开动画路径
    NSMutableArray *values = [NSMutableArray array];
    NSMutableArray *timingFunctions = [NSMutableArray array];
    UIBezierPath *strokePath = [UIBezierPath bezierPath];
    for (NSInteger i = 1; i < 35; i++) {
        if (i < 30) {
            [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-i, self.bodyCenterPoint.y - i/15.0) radius:self.bodyRadius startAngle:ZRDegreesToRadians(-90-(i-1)) endAngle:ZRDegreesToRadians(-90-i) clockwise:NO];
        } else {
            [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-31 *self.uiScale, self.bodyCenterPoint.y-2 *self.uiScale) radius:self.bodyRadius startAngle:ZRDegreesToRadians(-90-(i-1)) endAngle:ZRDegreesToRadians(-90-i) clockwise:NO];
        }
    }
    for (NSInteger i = 1; i < 17; i++) {
        [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-31 *self.uiScale, self.bodyCenterPoint.y-2 *self.uiScale) radius:self.bodyRadius  startAngle:ZRDegreesToRadians(-124-(i-1)) endAngle:ZRDegreesToRadians(-124-i) clockwise:NO];
    }
    for (NSInteger i = 1; i < 5; i++) {
        [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-31 *self.uiScale, self.bodyCenterPoint.y-2 *self.uiScale) radius:self.bodyRadius startAngle:ZRDegreesToRadians(-140 + (i-1)) endAngle:ZRDegreesToRadians(-140 + i) clockwise:YES];
    }
    for (NSInteger i = 0; i < 6; i++) {
        [strokePath addArcWithCenter:CGPointMake(self.bodyCenterPoint.x-31 *self.uiScale, self.bodyCenterPoint.y-2 *self.uiScale) radius:self.bodyRadius-3 *self.uiScale startAngle:ZRDegreesToRadians(-140-(i-1)) endAngle:ZRDegreesToRadians(-140-i) clockwise:NO];
    }
    for (NSInteger i = 1; i < 40; i++) {
        [values addObject:@(ZRDegreesToRadians(-i))];
        [timingFunctions addObject:self.animationTimingFunction];
    }
    // 路径
    CAKeyframeAnimation *lidAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    lidAnimation.path = strokePath.CGPath;
    lidAnimation.removedOnCompletion = NO;
    lidAnimation.fillMode = kCAFillModeForwards;
    lidAnimation.duration = KZRBirthdayAnimationDuriation;
    lidAnimation.timingFunction = self.animationTimingFunction;
    [self.animationList addObject:lidAnimation];
    
    // 旋转
    CAKeyframeAnimation *rotationAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.duration = KZRBirthdayAnimationDuriation;
    rotationAnimation.removedOnCompletion = NO;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.values = values;
    rotationAnimation.timingFunctions = timingFunctions;
    [self.animationList addObject:rotationAnimation];
    
    // group
    CAAnimationGroup * birthdayLidAnimationGroup = [CAAnimationGroup animation];
    birthdayLidAnimationGroup.animations = @[lidAnimation,rotationAnimation];
    birthdayLidAnimationGroup.duration = KZRBirthdayAnimationDuriation;
    birthdayLidAnimationGroup.delegate = self;
    birthdayLidAnimationGroup.removedOnCompletion = NO;
    birthdayLidAnimationGroup.fillMode = kCAFillModeForwards;
    birthdayLidAnimationGroup.timingFunction = self.animationTimingFunction;
    [birthdayLidAnimationGroup setValue:@(ZRBirthdayAnimationTypeLidGroup) forKey:ZRBirthdayAnimationIdentifier];
    [self.animationList addObject:birthdayLidAnimationGroup];
    [self.birthdayLidLayer addAnimation:birthdayLidAnimationGroup forKey:@"birthdayLidAnimation"];
}

// 带happyBirthday字体的layer透明度渐变为0
- (void)animationForHappyBirthdayOpacity {
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = [NSNumber numberWithFloat:1.0];
    opacityAnimation.toValue = [NSNumber numberWithFloat:0.0];
    opacityAnimation.duration = KZRBirthdayDelayDuriation;
    opacityAnimation.beginTime = KZRBirthdayAnimationDuriation;
    opacityAnimation.removedOnCompletion = NO;
    opacityAnimation.fillMode = kCAFillModeForwards;
    [self.animationList addObject:opacityAnimation];
    
    CAAnimationGroup * opacityAnimationGroup = [CAAnimationGroup animation];
    opacityAnimationGroup.animations = @[opacityAnimation];
    opacityAnimationGroup.duration = KZRBirthdayDelayDuriation +KZRBirthdayAnimationDuriation;
    opacityAnimationGroup.delegate = self;
    opacityAnimationGroup.removedOnCompletion = NO;
    opacityAnimationGroup.fillMode = kCAFillModeForwards;
    opacityAnimationGroup.timingFunction = self.animationTimingFunction;
    [opacityAnimationGroup setValue:@(ZRBirthdayAnimationTypeHappyBirthdayHidden) forKey:ZRBirthdayAnimationIdentifier];
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

#pragma mark - animationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSInteger keyPath = [[anim valueForKey:ZRBirthdayAnimationIdentifier] integerValue];
    if (ZRBirthdayAnimationTypeLidGroup == keyPath) {
        [self animationForBirthdayHeart];
        [self animationForBirthdayMusic];
    } else if (ZRBirthdayAnimationTypeHappyBirthdayShow == keyPath) {
        [self animationForHappyBirthdayOpacity];
    } else if (ZRBirthdayAnimationTypeHappyBirthdayHidden == keyPath) {
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

@end
