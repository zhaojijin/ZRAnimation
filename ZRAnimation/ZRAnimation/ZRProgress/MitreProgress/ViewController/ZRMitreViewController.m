//
//  ZRMitreViewController.m
//  ZRAnimation
//
//  Created by zhaojijin on 2019/11/28.
//  Copyright © 2019 RobinZhao. All rights reserved.
//

#import "ZRMitreViewController.h"
#import "ZRMitreView.h"

@interface ZRMitreViewController ()

@property (nonatomic, strong) ZRMitreView *mitreView;

@end

@implementation ZRMitreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"斜角进度条";
    self.mitreView = [[ZRMitreView alloc] initWithFrame:CGRectMake(40, 200, [UIScreen mainScreen].bounds.size.width-80, 21)];
    self.mitreView.layer.masksToBounds = YES;
    self.mitreView.layer.cornerRadius = 4;
    [self.view addSubview:self.mitreView];
    [self.mitreView updateProgress:0.99 fallColor:[UIColor greenColor] raiseColor:[UIColor redColor] animaiton:NO];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(40, CGRectGetMaxY(self.mitreView.frame) + 100, 300, 30)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"点击屏幕更换百分比";
    [self.view addSubview:label];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    CGFloat progress = arc4random() % 100;
    progress = progress / 100.0;
    UIColor *fallColor = [UIColor greenColor];
    UIColor *rColor = [UIColor redColor];
//    UIColor *fallColor = [self randomColor];
//    UIColor *rColor = [self randomColor];
    [self.mitreView updateProgress:progress fallColor:fallColor raiseColor:rColor animaiton:YES];
}

- (UIColor *)randomColor {
    return [UIColor colorWithRed:(arc4random() % 256)/255.0 green:(arc4random() % 256)/255.0 blue:(arc4random() % 256)/255.0 alpha:1];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
