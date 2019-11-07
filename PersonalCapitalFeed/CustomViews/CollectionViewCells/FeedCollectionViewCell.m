//
//  FeedCollectionViewCell.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "FeedCollectionViewCell.h"
#import "UIView+Constraints.h"

@implementation FeedCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.cornerRadius = 0.0;
        [self.contentView addSubview:self.imageView];
        [self.imageView addConstraintsToView:self.contentView leadingOffset:0 isleadingConstraintActive:YES topOffset:0 isTopConstraintActive:YES bottomOffset:50 isBottomConstraintActive:YES trailingOffset:0 isTrailingConstraintActive:YES];
        
        self.titleView = [[UILabel alloc] initWithFrame:CGRectZero];
        self.titleView.textAlignment = NSTextAlignmentCenter;
        [self.titleView setFont:[UIFont systemFontOfSize:15 weight:UIFontWeightRegular]];
        [self.contentView addSubview:self.titleView];
        [self.titleView addConstraintsToView:self.contentView leadingOffset:10 isleadingConstraintActive:YES topOffset:0 isTopConstraintActive:NO bottomOffset:15 isBottomConstraintActive:YES trailingOffset:10 isTrailingConstraintActive:YES];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        self.activityIndicator.alpha = 1.0;
        [self.contentView addSubview:self.activityIndicator];
        [self.activityIndicator addConstraintsToView:self.contentView isCenterHorizontally:YES isCenterVertically:YES];
    }
    
    return self;
}


@end
