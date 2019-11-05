//
//  FeedCollectionViewCell.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "FeedCollectionViewCell.h"

@implementation FeedCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.contentView.frame.size.width, self.contentView.frame.size.height - 50)];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        self.imageView.clipsToBounds = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        self.imageView.layer.cornerRadius = 0.0;
        [self.contentView addSubview:self.imageView];
        
        self.titleView = [[UILabel alloc] initWithFrame:CGRectMake(10, self.imageView.frame.size.height + 10, self.contentView.frame.size.width - 20, 25)];
        [self.titleView setFont:[UIFont systemFontOfSize:20 weight:UIFontWeightRegular]];
        [self.contentView addSubview:self.titleView];
        
        self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
        self.activityIndicator.center = CGPointMake(self.contentView.frame.size.width / 2, self.contentView.frame.size.height / 2);
        self.activityIndicator.alpha = 1.0;
        [self.contentView addSubview:self.activityIndicator];
    }
    
    return self;
}


@end
