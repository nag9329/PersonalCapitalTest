//
//  ProminentCollectionViewCell.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "ProminentCollectionViewCell.h"

@implementation ProminentCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 100)];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.cornerRadius = 0.0;
        [self.contentView addSubview:self.imageView];
        
        self.titleView = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imageView.frame.size.height + 10, self.contentView.frame.size.width - 20, 30)];
        self.titleView.numberOfLines = 1;
        [self.titleView setFont:[UIFont systemFontOfSize:25 weight:UIFontWeightRegular]];
        [self.contentView addSubview:self.titleView];
        
        self.summaryView = [[UILabel alloc] initWithFrame:CGRectMake(10, self.titleView.frame.origin.y + self.titleView.frame.size.height + 10, self.contentView.frame.size.width - 20, 50)];
        self.summaryView.numberOfLines = 2;
        [self.summaryView setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightThin]];
        [self.contentView addSubview:self.summaryView];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        self.activityIndicator.center = CGPointMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2);
        self.activityIndicator.alpha = 1.0;
        [self.contentView addSubview:self.activityIndicator];
    }
    
    return self;
}

@end
