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

- (NSDictionary *)getParameterWithDelimited: (BOOL)delimited warnings: (BOOL)warnings;

- (NSDictionary *)postParameterWithFollow: (NSString *)follow track: (NSString *)track locations: (NSString *)locations delimited: (BOOL)delimited warnings: (BOOL)warnings;

- (SLRequest *)createURLRequestWithParameters: (NSDictionary *)parameters type: (streamingAPIType)type;

@end
