//
//  NetworkRequest.h
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Feed.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^NetworkRequestSuccess)(NSArray<Feed *> *feeds);
typedef void (^NetworkRequestFailure)(NSString *failureReason, NSInteger statusCode);

@interface NetworkRequest : NSObject

+ (id)sharedManager;
- (void)requestFeedsWithSuccess:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure;

@end

NS_ASSUME_NONNULL_END
