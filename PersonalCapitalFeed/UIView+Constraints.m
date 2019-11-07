//
//  UIView+Constraints.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "UIView+Constraints.h"


@implementation UIView (Constraints)

-(void)addConstraintsToView:(UIView *)view leadingOffset:(CGFloat)leadingOffset isleadingConstraintActive:(BOOL)isleadingConstraintActive topOffset:(CGFloat)topOffset isTopConstraintActive:(BOOL)isTopConstraintActive bottomOffset:(CGFloat)bottomOffset isBottomConstraintActive:(BOOL)isBottomConstraintActive trailingOffset:(CGFloat)trailingOffset isTrailingConstraintActive:(BOOL)isTrailingConstraintActive
{
    if (view == nil) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.leadingAnchor constraintEqualToAnchor:view.leadingAnchor constant:leadingOffset] setActive:isleadingConstraintActive];
    [[self.topAnchor constraintEqualToAnchor:view.topAnchor constant:topOffset] setActive:isTopConstraintActive];
    [[self.bottomAnchor constraintEqualToAnchor:view.safeAreaLayoutGuide.bottomAnchor constant:-bottomOffset] setActive:isBottomConstraintActive];
    [[self.trailingAnchor constraintEqualToAnchor:view.trailingAnchor constant:-trailingOffset] setActive:isTrailingConstraintActive];
}

- (void)addConstraintsToView:(UIView *)view isCenterHorizontally:(BOOL)isCenterHorizontally isCenterVertically:(BOOL)isCenterVertically
{
    if (view == nil) {
        return;
    }
    
    self.translatesAutoresizingMaskIntoConstraints = NO;
    [[self.centerXAnchor constraintEqualToAnchor:view.centerXAnchor] setActive:isCenterHorizontally];
    [[self.centerYAnchor constraintEqualToAnchor:view.centerYAnchor] setActive:isCenterVertically];
}

@end
