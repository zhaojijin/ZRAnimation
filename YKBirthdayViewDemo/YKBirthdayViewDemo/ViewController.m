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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UIApplication sharedApplication].statusBarHidden = YES;
    
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
    [[YKBirthdayMgr shareInstance] showBirthdayViewInViewController:self birthdayItem:birthdayItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
