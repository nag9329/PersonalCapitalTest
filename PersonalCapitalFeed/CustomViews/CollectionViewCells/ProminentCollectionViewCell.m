//
//  ProminentCollectionViewCell.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "ProminentCollectionViewCell.h"
#import "UIView+Constraints.h"

@implementation ProminentCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.cornerRadius = 0.0;
        [self.contentView addSubview:self.imageView];
        [self.imageView addConstraintsToView:self.contentView leadingOffset:0 isleadingConstraintActive:YES topOffset:0 isTopConstraintActive:YES bottomOffset:100 isBottomConstraintActive:YES trailingOffset:0 isTrailingConstraintActive:YES];
        
        self.titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleView.textAlignment = NSTextAlignmentCenter;
        [self.titleView setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightRegular]];
        self.titleView.numberOfLines = 1;
        [self.contentView addSubview:self.titleView];
        [self.titleView addConstraintsToView:self.contentView leadingOffset:10 isleadingConstraintActive:YES topOffset:0 isTopConstraintActive:NO bottomOffset:55 isBottomConstraintActive:YES trailingOffset:10 isTrailingConstraintActive:YES];
        
        self.summaryView = [[UILabel alloc] initWithFrame:CGRectZero];
        self.summaryView.numberOfLines = 2;
        [self.summaryView setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightThin]];
        [self.contentView addSubview:self.summaryView];
        [self.summaryView addConstraintsToView:self.contentView leadingOffset:10 isleadingConstraintActive:YES topOffset:0 isTopConstraintActive:NO bottomOffset:15 isBottomConstraintActive:YES trailingOffset:10 isTrailingConstraintActive:YES];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        self.activityIndicator.alpha = 1.0;
        [self.contentView addSubview:self.activityIndicator];
        [self.activityIndicator addConstraintsToView:self.contentView isCenterHorizontally:YES isCenterVertically:YES];
    }
    
    return self;
}

@end
