//
//  YKHomeViewController.m
//  YKBirthdayViewDemo
//
//  Created by Robin on 2018/7/3.
//  Copyright © 2018年 yinker. All rights reserved.
//

#import "YKHomeViewController.h"
#import "YKHomeAdapter.h"
#import "YKHomeBirthdayDetailViewController.h"
#import "ZRCardDanceViewController.h"

@interface YKHomeViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) YKHomeAdapter *birthdyaAdapter;

@end

@implementation YKHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupSubviews {
    self.birthdyaAdapter = [[YKHomeAdapter alloc] init];
    [self.birthdyaAdapter addDelegate:self.tableView];
    __weak  typeof(self) weakSelf  = self;
    self.birthdyaAdapter.birthdayClickBlock = ^(YKAnimationType birthdayType) {
        [weakSelf handleJumpDetailEvent:birthdayType];
    };
    self.title = @"首页";
}

- (void)handleJumpDetailEvent:(YKAnimationType)birthdayType {
    switch (birthdayType) {
        case YKAnimationTypeHeart:
        case YKAnimationTypeEnvelopeOne:
        case YKAnimationTypeEnvelopeTwo: {
            YKHomeBirthdayDetailViewController *vc = [[YKHomeBirthdayDetailViewController alloc] initWithNibName:@"YKHomeBirthdayDetailViewController" bundle:nil];
            vc.birthdayType = birthdayType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case YKAnimationTypeCardDance: {
            ZRCardDanceViewController *cardDanceViewController = [[ZRCardDanceViewController alloc] initWithNibName:@"ZRCardDanceViewController" bundle:nil];
            [self.navigationController pushViewController:cardDanceViewController animated:YES];
        }
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
