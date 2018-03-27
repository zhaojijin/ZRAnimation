//
//  ViewController.m
//  YKBirthdayViewDemo
//
//  Created by zhaojijin on 2016/12/6.
//  Copyright © 2016年 yinker. All rights reserved.
//

#import "ViewController.h"
#import "YKBirthdayMgr.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet UIButton *bgButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    BOOL iPhoneX = [UIScreen mainScreen].bounds.size.height == 812;
    NSString *imageName = iPhoneX ? @"bg_iPhoneX.jpg" : @"bg_normal.jpg";
    [self.bgButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    
    [self showBirthdayViewController];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)actionEvent:(id)sender {
    [self showBirthdayViewController];
}

- (void)showBirthdayViewController {
    YKBirthdayItem *birthdayItem = [[YKBirthdayItem alloc] init];
    birthdayItem.birthdayTitle = @"亲爱的戎马天涯";
    birthdayItem.birthdaySubTitle = @"简理财精心为您准备了3000元";
    birthdayItem.birthdayDescriptionTitle = @"生日礼金，和一份特别惊喜！";
    [[YKBirthdayMgr shareInstance] showBirthdayViewInViewController:self birthdayItem:birthdayItem receiveBlock:^{
        NSLog(@"动画完成后做一些处理");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
