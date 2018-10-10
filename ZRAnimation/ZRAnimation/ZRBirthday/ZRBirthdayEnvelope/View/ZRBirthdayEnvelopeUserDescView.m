//
//  ZRBirthdayEnvelopeUserDescView.m
//  ZRAnimation
//
//  Created by Robin on 2018/10/10.
//  Copyright © 2018年 RobinZhao. All rights reserved.
//

#import "ZRBirthdayEnvelopeUserDescView.h"
#import "ZRBirthdayEnvelopeUserFriendsCCell.h"
#import "ZRBirthdayEnvelopeModel.h"
#import "ZRBirthdayEnvelopeFriendsItem.h"
#import "UIColor+ZRColor.h"

@interface ZRBirthdayEnvelopeUserDescView () <UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>

@property (nonatomic, strong) NSArray *friendsList;
@property (nonatomic, assign) CGFloat collectionViewWidth;
@property (nonatomic, assign) CGFloat uiScale;

@end

static CGFloat const ZRCollectionViewHeight = 77.0;

@implementation ZRBirthdayEnvelopeUserDescView

- (instancetype)initWithFrame:(CGRect)frame birthdayModel:(ZRBirthdayEnvelopeModel *)birthdayModel {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupSubviews:frame birthdayModel:birthdayModel];
    }
    return self;
}

#pragma mark - Event

- (void)setupSubviews:(CGRect)frame birthdayModel:(ZRBirthdayEnvelopeModel *)birthdayModel {
    self.uiScale = 1;
    CGFloat orginX = 28.0 * self.uiScale;
    CGFloat orginY = birthdayModel.birthdayLayerType == ZRBirthdayLayerTypeForA ? 50.0 *self.uiScale : 43.0 *self.uiScale;
    CGFloat width = frame.size.width *self.uiScale - 2 * orginX;
    UILabel *respectLabel = [[UILabel alloc] initWithFrame:CGRectMake(orginX, orginY, width, 0)];
    respectLabel.textColor = [UIColor zr_colorWithValue:0xff781a22];
    respectLabel.font = [UIFont systemFontOfSize:15];
    respectLabel.text = birthdayModel.birthdayLayerName;
    [respectLabel sizeToFit];
    [self addSubview:respectLabel];
    CGFloat descTopMargin = birthdayModel.birthdayLayerType == ZRBirthdayLayerTypeForA ? 12 *self.uiScale : 10 *self.uiScale;
    UILabel *descLabel = [[UILabel alloc] initWithFrame:CGRectMake(orginX, CGRectGetMaxY(respectLabel.frame) + descTopMargin, width, 0)];
    descLabel.font = [UIFont systemFontOfSize:13];
    descLabel.numberOfLines = 0;
    descLabel.lineBreakMode = NSLineBreakByWordWrapping;
    descLabel.textColor = [UIColor zr_colorWithValue:0xff781a22];
    CGFloat lineSpacing = birthdayModel.birthdayLayerType == ZRBirthdayLayerTypeForA ? 10 *self.uiScale : 5 *self.uiScale;
    descLabel.attributedText = [self getAttributeText:birthdayModel.birthdayLayerDesc lineSpacing:lineSpacing];
    [descLabel sizeToFit];
    [self addSubview:descLabel];
    if (ZRBirthdayLayerTypeForB == birthdayModel.birthdayLayerType) {
        self.friendsList = birthdayModel.friendsBirthdayInfo;
        if (self.friendsList.count > 3) {
            ZRBirthdayEnvelopeFriendsItem *friendItem = self.friendsList[3];
            friendItem.isMore = YES;
        }
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        self.collectionViewWidth = frame.size.width-24;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(12 *self.uiScale, CGRectGetMaxY(descLabel.frame) + 10 *self.uiScale, self.collectionViewWidth, ZRCollectionViewHeight *self.uiScale) collectionViewLayout:flowLayout];
        collectionView.delegate = self;
        collectionView.dataSource = self;
        collectionView.backgroundColor = [UIColor clearColor];
        [self addSubview:collectionView];
        [collectionView registerNib:[UINib nibWithNibName:@"ZRBirthdayEnvelopeUserFriendsCCell" bundle:nil] forCellWithReuseIdentifier:@"ZRBirthdayEnvelopeUserFriendsCCell"];
    }
}

- (NSAttributedString *)getAttributeText:(NSString *)text lineSpacing:(CGFloat)lineSpacing {
    if (text.length == 0) {
        return nil;
    }
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = lineSpacing;
    style.lineBreakMode = NSLineBreakByWordWrapping;
    NSAttributedString *att = [[NSAttributedString alloc] initWithString:text attributes:@{NSKernAttributeName : @(2),NSParagraphStyleAttributeName : style}];
    return att;
}

#pragma mark -delegate dataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.friendsList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * cellIdentifier = @"ZRBirthdayEnvelopeUserFriendsCCell";
    ZRBirthdayEnvelopeUserFriendsCCell * cell = (ZRBirthdayEnvelopeUserFriendsCCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    NSInteger item = indexPath.item;
    if (item < self.friendsList.count) {
        ZRBirthdayEnvelopeFriendsItem *friendsItem = self.friendsList[item];
        cell.friendsItem = friendsItem;
    }
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item >= 0
        && indexPath.item < 3
        && self.friendsList.count > 0) {
        NSInteger count = self.friendsList.count > 3 ? 3 : self.friendsList.count;
        if (self.friendsList.count > 3) {
            return CGSizeMake(self.uiScale *(self.collectionViewWidth-25)/count, ZRCollectionViewHeight *self.uiScale);
        } else {
            return CGSizeMake(self.uiScale *self.collectionViewWidth/count, ZRCollectionViewHeight *self.uiScale);
        }
    } else {
        return CGSizeMake(25.0 *self.uiScale, ZRCollectionViewHeight *self.uiScale);
    }
}

@end
