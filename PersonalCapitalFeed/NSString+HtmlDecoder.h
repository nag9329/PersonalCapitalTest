//
//  NSString+HtmlDecoder.h
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 11/6/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (HtmlDecoder)

- (NSString *)stringByDecodingXMLEntities;

@end

NS_ASSUME_NONNULL_END
