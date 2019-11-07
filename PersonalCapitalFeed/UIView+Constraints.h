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

-(void)addConstraintsToView:(UIView *)view leadingOffset:(CGFloat)leadingOffset isleadingConstraintActive:(BOOL)isleadingConstraintActive topOffset:(CGFloat)topOffset isTopConstraintActive:(BOOL)isTopConstraintActive
    bottomOffset:(CGFloat)bottomOffset isBottomConstraintActive:(BOOL)isBottomConstraintActive
    trailingOffset:(CGFloat)trailingOffset isTrailingConstraintActive:(BOOL)isTrailingConstraintActive;
- (void)addConstraintsToView:(UIView *)view isCenterHorizontally:(BOOL)isCenterHorizontally isCenterVertically:(BOOL)isCenterVertically;

@end

NS_ASSUME_NONNULL_END
