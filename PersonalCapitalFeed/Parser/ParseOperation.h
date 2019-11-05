//
//  FeedParser.h
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/31/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

NS_ASSUME_NONNULL_BEGIN

@interface ParseOperation : NSOperation

// A block to call when an error is encountered during parsing.
@property (nonatomic, copy) void (^errorHandler)(NSError *error);

// NSArray containing feed instances for each entry parsed
// from the input data.
// Only meaningful after the operation has completed.
@property (nonatomic, strong, readonly) NSArray *feeds;

// The initializer for this NSOperation subclass.
- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
