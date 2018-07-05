//
//  YKBirthdayUserFriendsCollectionViewCell.m
//  SimpleFinance
//
//  Created by zhaojijin on 2017/10/19.
//  Copyright © 2017年 yinker. All rights reserved.
//

#import "YKBirthdayUserFriendsCollectionViewCell.h"
#import "YKBirthdayFriendsItem.h"

@interface YKBirthdayUserFriendsCollectionViewCell ()

@property (nonatomic, strong) IBOutlet UIImageView *moreImageView;
@property (nonatomic, strong) IBOutlet UIImageView *headImageView;
@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

@end

@implementation YKBirthdayUserFriendsCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 21;
    // Initialization code
}

- (void)setFriendsItem:(YKBirthdayFriendsItem *)friendsItem {
    _friendsItem = friendsItem;
    if (friendsItem.isMore) {
        self.containerView.hidden = YES;
        self.moreImageView.hidden = NO;
    } else {
        self.containerView.hidden = NO;
        self.moreImageView.hidden = YES;
        
//        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:friendsItem.imageUrl] placeholderImage:[UIImage imageNamed:@"defaultHeadPicture"]];
        self.nameLabel.text = friendsItem.title;
    }
}

@end
