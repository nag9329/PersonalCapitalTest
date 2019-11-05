//
//  NetworkRequest.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/30/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "NetworkRequest.h"
#import "ParseOperation.h"

static NetworkRequest *sharedManager = nil;
static NSString *const feedUrl = @"https://www.personalcapital.com/blog/feed/?cat=3,891,890,68,284";

@interface NetworkRequest()

// the queue to run our "ParseOperation"
@property (nonatomic, strong) NSOperationQueue *queue;

// the NSOperation driving the parsing of the RSS feed
@property (nonatomic, strong) ParseOperation *parser;

@end

@implementation NetworkRequest

+ (NetworkRequest*)sharedManager
{
    static dispatch_once_t once;
    dispatch_once(&once, ^
                  {
        sharedManager = [[NetworkRequest alloc] init];
    });
    return sharedManager;
}

- (id)init
{
    if ((self = [super init])) {
    }
    return self;
}

- (void)requestFeedsWithSuccess:(NetworkRequestSuccess)success failure:(NetworkRequestFailure)failure
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:feedUrl]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200)
        {
            // create the queue to run our ParseOperation
            self.queue = [[NSOperationQueue alloc] init];
            
            // create an ParseOperation (NSOperation subclass) to parse the RSS feed data so that the UI is not blocked
            self.parser = [[ParseOperation alloc] initWithData:data];
            
            __weak NetworkRequest *weakSelf = self;
            
            self.parser.errorHandler = ^(NSError *parseError) {
                failure(parseError.localizedFailureReason, httpResponse.statusCode);
            };
            
            // referencing parser from within its completionBlock would create a retain cycle
            __weak ParseOperation *weakParser = self.parser;
            
            self.parser.completionBlock = ^(void) {
                // The completion block may execute on any thread.  Because operations
                success(weakParser.feeds);
                // we are finished with the queue and our ParseOperation
                weakSelf.queue = nil;
            };
            
            [self.queue addOperation:self.parser]; // this will start the "ParseOperation"
        }
        else
        {
            failure(error.localizedFailureReason, httpResponse.statusCode);
        }
    }];
    [dataTask resume];
}
@end
