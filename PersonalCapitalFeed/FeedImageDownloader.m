//
//  FeedImageDownloader.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 11/4/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "FeedImageDownloader.h"
#import "Feed.h"

@interface FeedImageDownloader ()

@property (nonatomic, strong) NSURLSessionDataTask *sessionTask;

@end

@implementation FeedImageDownloader

// -------------------------------------------------------------------------------
//    startDownload
// -------------------------------------------------------------------------------
- (void)startDownload
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.feed.feedImageUrl]];
    
    // create an session data task to obtain and download the feed image
    _sessionTask = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                   completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock: ^{
                // Set appIcon and clear temporary data/image
                UIImage *image = [[UIImage alloc] initWithData:data];
                self.feed.feedImage = image;
                
                // call our completion handler to tell our client that our feed image is ready for display
                if (self.completionHandler != nil)
                {
                    self.completionHandler();
                }
            }];
        }
    }];
    
    [self.sessionTask resume];
}

// -------------------------------------------------------------------------------
//    cancelDownload
// -------------------------------------------------------------------------------
- (void)cancelDownload
{
    [self.sessionTask cancel];
    _sessionTask = nil;
}

@end
