//
//  FeedImageDownloader.h
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 11/4/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class Feed;

NS_ASSUME_NONNULL_BEGIN

@interface FeedImageDownloader : NSObject

@property (nonatomic, strong) Feed *feed;
@property (nonatomic, copy) void (^completionHandler)(void);

- (void)startDownload;
- (void)cancelDownload;

@end

NS_ASSUME_NONNULL_END
