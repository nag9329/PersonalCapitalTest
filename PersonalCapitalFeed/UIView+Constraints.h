//
//  UIView+Constraints.h
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Constraints)

-(void)addConstraintsToSuperviewWithLeadingOffset:(CGFloat)leadingOffset topOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset trailingOffset:(CGFloat)trailingOffset;

@end

NS_ASSUME_NONNULL_END
