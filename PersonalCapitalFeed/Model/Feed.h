//
//  Feed.h
//  PersonalCapitalFeed
//
//  Created by Nagarjuna Ramagiri on 10/31/19.
//  Copyright © 2019 Nagarjuna Ramagiri. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Feed : NSObject

@property (strong, nonatomic) NSString *feedTitle;
@property (strong, nonatomic) NSString *feedLink;
@property (strong, nonatomic) NSString *feedSummary;
@property (strong, nonatomic) NSString *feedImageUrl;
@property (strong, nonatomic) UIImage *feedImage;

@end

NS_ASSUME_NONNULL_END
