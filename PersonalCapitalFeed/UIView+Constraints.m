//
//  UIView+Constraints.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "UIView+Constraints.h"


@implementation UIView (Constraints)

-(void)addConstraintsToSuperviewWithLeadingOffset:(CGFloat)leadingOffset topOffset:(CGFloat)topOffset bottomOffset:(CGFloat)bottomOffset trailingOffset:(CGFloat)trailingOffset
{
    if (self.superview == nil) {
        return;
    }

    self.translatesAutoresizingMaskIntoConstraints = false;
    [[self.leadingAnchor constraintEqualToAnchor:self.superview.leadingAnchor constant:leadingOffset] setActive:true];
    [[self.topAnchor constraintEqualToAnchor:self.superview.topAnchor constant:topOffset] setActive:true];
    [[self.bottomAnchor constraintEqualToAnchor:self.superview.bottomAnchor constant:-bottomOffset] setActive:true];
    [[self.trailingAnchor constraintEqualToAnchor:self.superview.trailingAnchor constant:-trailingOffset] setActive:true];
}

-(void)addConstaintsWithHeight:(CGFloat)height width:(CGFloat)width
{
    [[self.heightAnchor constraintEqualToConstant:height] setActive:true];
    [[self.widthAnchor constraintEqualToConstant:width] setActive:true];
}

@end
