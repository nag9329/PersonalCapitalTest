//
//  Feed.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/31/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "Feed.h"

@implementation Feed

-(id)init{
    self = [super init];
    if (self) {
        self.feedTitle = @"";
        self.feedLink = @"";
        self.feedSummary = @"";
        self.feedImageUrl = @"";
    }
    return self;
}

@end
