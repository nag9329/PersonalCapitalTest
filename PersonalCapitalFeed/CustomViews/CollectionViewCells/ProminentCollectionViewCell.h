//
//  ProminentCollectionViewCell.h
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProminentCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UILabel *titleView;
@property (strong, nonatomic) UILabel *summaryView;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;

@end

NS_ASSUME_NONNULL_END
