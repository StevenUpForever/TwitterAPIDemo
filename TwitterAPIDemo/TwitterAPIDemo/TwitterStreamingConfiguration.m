//
//  TwitterStreamingConfiguration.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "TwitterStreamingConfiguration.h"

NSString * const kStreamingPulicFilter = @"https://stream.twitter.com/1.1/statuses/filter.json";
NSString * const kStreamingPublicSample = @"https://stream.twitter.com/1.1/statuses/sample.json";
NSString * const kStreamingUserStreams = @"https://userstream.twitter.com/1.1/user.json";

@implementation TwitterStreamingConfiguration


+ (NSDictionary *)parameterWithFollow: (NSArray<NSNumber *> *)follow track: (NSArray<NSString *> *)track locations: (NSArray<NSNumber *> *)locations delimited: (BOOL)delimited warnings: (BOOL)warnings {
    
}

@end
