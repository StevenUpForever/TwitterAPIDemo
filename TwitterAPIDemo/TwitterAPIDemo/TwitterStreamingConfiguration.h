//
//  TwitterStreamingConfiguration.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>

typedef NS_ENUM(NSUInteger, streamingAPIType) {
    streamingAPIPublicFilter = 0,
    streamingAPIPublicSample,
    streamingAPIUserStreams,
};

@interface TwitterStreamingConfiguration : NSObject

- (instancetype)initWithType: (streamingAPIType)type parameters: (NSDictionary *)parameters account: (ACAccount *)account;

+ (NSDictionary *)postParameterWithFollow: (NSString *)follow track: (NSString *)track locations: (NSString *)locations;

- (NSURLRequest *)createURLRequest;

@end
