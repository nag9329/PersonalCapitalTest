//
//  FeedParser.m
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/31/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import "ParseOperation.h"
#import "Feed.h"

// string contants found in the RSS feed
static NSString *kChannel = @"channel";
static NSString *kItem = @"item";
static NSString *kTitle = @"title";
static NSString *kArticleLink = @"link";
static NSString *kSummary = @"description";
static NSString *kImageUrl = @"media:content";

@interface ParseOperation () <NSXMLParserDelegate>

// Redeclare feeds so we can modify it within this class
@property (nonatomic, strong) NSArray *feeds;

@property (nonatomic, strong) NSData *dataToParse;
@property (nonatomic, strong) NSMutableArray *workingArray;
@property (nonatomic, strong) Feed *workingEntry;  // the current feed or XML entry being parsed
@property (nonatomic, strong) NSMutableString *workingPropertyString;
@property (nonatomic, strong) NSArray *elementsToParse;
@property (nonatomic, readwrite) BOOL storingCharacterData;

@end

@implementation ParseOperation

// -------------------------------------------------------------------------------
//    initWithData:
// -------------------------------------------------------------------------------
- (instancetype)initWithData:(NSData *)data
{
    self = [super init];
    if (self != nil)
    {
        _dataToParse = data;
        _elementsToParse = @[kChannel, kItem, kTitle, kArticleLink, kSummary];
    }
    return self;
}

// -------------------------------------------------------------------------------
//    main
//  Entry point for the operation.
//  Given data to parse, use NSXMLParser and process all the feeds
// -------------------------------------------------------------------------------
- (void)main
{
    // The default implemetation of the -start method sets up an autorelease pool
    // just before invoking -main however it does NOT setup an excption handler
    // before invoking -main.  If an exception is thrown here, the app will be
    // terminated.
    
    _workingArray = [NSMutableArray array];
    _workingPropertyString = [NSMutableString string];
    
    // It's also possible to have NSXMLParser download the data, by passing it a URL, but this is not
    // desirable because it gives less control over the network, particularly in responding to
    // connection errors.
    //
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.dataToParse];
    [parser setDelegate:self];
    [parser parse];
    
    if (![self isCancelled])
    {
        // Set feeds to the result of our parsing
        self.feeds = [NSArray arrayWithArray:self.workingArray];
    }
    
    self.workingArray = nil;
    self.workingPropertyString = nil;
    self.dataToParse = nil;
}

#pragma mark - RSS processing

// -------------------------------------------------------------------------------
//    parser:didStartElement:namespaceURI:qualifiedName:attributes:
// -------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:kItem])
    {
        self.workingEntry = [[Feed alloc] init];
    } else if ([elementName isEqualToString:kImageUrl])
    {
        self.workingEntry.feedImageUrl = [attributeDict objectForKey:@"url"];
    }
    self.storingCharacterData = [self.elementsToParse containsObject:elementName];
}

// -------------------------------------------------------------------------------
//    parser:didEndElement:namespaceURI:qualifiedName:
// -------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName
{
    if (self.workingEntry != nil)
    {
        if (self.storingCharacterData)
        {
            NSString *trimmedString = [self.workingPropertyString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            [self.workingPropertyString setString:@""];  // clear the string for next time
            if ([elementName isEqualToString:kTitle])
            {
                self.workingEntry.feedTitle = trimmedString;
            }
            else if ([elementName isEqualToString:kArticleLink])
            {
                self.workingEntry.feedLink = trimmedString;
            }
            else if ([elementName isEqualToString:kSummary])
            {
                self.workingEntry.feedSummary = trimmedString;
            }
        }
        else if ([elementName isEqualToString:kItem])
        {
            [self.workingArray addObject:self.workingEntry];
            self.workingEntry = nil;
        }
    }
}

// -------------------------------------------------------------------------------
//    parser:foundCharacters:
// -------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    if (self.storingCharacterData)
    {
        [self.workingPropertyString appendString:string];
    }
}

// -------------------------------------------------------------------------------
//    parser:parseErrorOccurred:
// -------------------------------------------------------------------------------
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError
{
    if (self.errorHandler)
    {
        self.errorHandler(parseError);
    }
}

@end
