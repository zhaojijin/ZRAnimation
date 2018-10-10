//
//  ZRHomeViewController.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRHomeViewController.h"
#import "ZRHomeAdapter.h"
#import "ZRBirthdayViewController.h"
#import "ZRCardDanceViewController.h"

@interface ZRHomeViewController ()

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) ZRHomeAdapter *birthdyaAdapter;

@end

@implementation ZRHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupSubviews];
    // Do any additional setup after loading the view from its nib.
}

- (void)setupSubviews {
    self.birthdyaAdapter = [[ZRHomeAdapter alloc] init];
    [self.birthdyaAdapter addDelegate:self.tableView];
    __weak  typeof(self) weakSelf  = self;
    self.birthdyaAdapter.birthdayClickBlock = ^(ZRAnimationType birthdayType) {
        [weakSelf handleJumpDetailEvent:birthdayType];
    };
    self.title = @"首页";
}

- (void)handleJumpDetailEvent:(ZRAnimationType)birthdayType {
    switch (birthdayType) {
        case ZRAnimationTypeHeart:
        case ZRAnimationTypeEnvelopeOne:
        case ZRAnimationTypeEnvelopeTwo: {
            ZRBirthdayViewController *vc = [[ZRBirthdayViewController alloc] initWithNibName:@"ZRBirthdayViewController" bundle:nil];
            vc.birthdayType = birthdayType;
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case ZRAnimationTypeCardDance: {
            ZRCardDanceViewController *cardDanceViewController = [[ZRCardDanceViewController alloc] initWithNibName:@"ZRCardDanceViewController" bundle:nil];
            [self.navigationController pushViewController:cardDanceViewController animated:YES];
        }
            break;
        default:
            break;
    }
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
