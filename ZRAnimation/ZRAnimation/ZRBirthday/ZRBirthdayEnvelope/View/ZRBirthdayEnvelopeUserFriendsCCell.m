//
//  ZRBirthdayEnvelopeUserFriendsCCell.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayEnvelopeUserFriendsCCell.h"
#import "ZRBirthdayEnvelopeFriendsItem.h"

@interface ZRBirthdayEnvelopeUserFriendsCCell ()

@property (nonatomic, strong) IBOutlet UIImageView *moreImageView;
@property (nonatomic, strong) IBOutlet UIImageView *headImageView;
@property (nonatomic, strong) IBOutlet UIView *containerView;
@property (nonatomic, strong) IBOutlet UILabel *nameLabel;

@end

@implementation ZRBirthdayEnvelopeUserFriendsCCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImageView.layer.masksToBounds = YES;
    self.headImageView.layer.cornerRadius = 21;
    // Initialization code
}

- (void)setFriendsItem:(ZRBirthdayEnvelopeFriendsItem *)friendsItem {
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
