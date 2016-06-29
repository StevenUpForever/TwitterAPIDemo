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

@interface TwitterStreamingConfiguration()

@end

@implementation TwitterStreamingConfiguration

- (NSDictionary *)getParameterWithDelimited: (BOOL)delimited warnings: (BOOL)warnings {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
    if (delimited) {
        [parameters setObject:@"length" forKey:@"delimited"];
    }
    if (warnings) {
        [parameters setObject:@"true" forKey:@"stall_warnings"];
    }
    return parameters;
}

- (NSDictionary *)postParameterWithFollow: (NSString *)follow track: (NSString *)track locations: (NSString *)locations delimited: (BOOL)delimited warnings: (BOOL)warnings {
    NSMutableDictionary *parameters = [[self getParameterWithDelimited:delimited warnings:warnings] mutableCopy];
    if (follow) {
        [parameters setObject:[follow stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"follow"];
    }
    if (track) {
        [parameters setObject:[track stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"track"];
    }
    if (locations) {
        [parameters setObject:[locations stringByReplacingOccurrencesOfString:@" " withString:@""] forKey:@"locations"];
    }
    return parameters;
}

- (SLRequest *)createURLRequestWithParameters: (NSDictionary *)parameters type: (streamingAPIType)type {
    NSString *urlStr;
    SLRequestMethod requestMethod;
    switch (type) {
        case streamingAPIPublicFilter:
            urlStr = kStreamingPulicFilter;
            requestMethod = SLRequestMethodPOST;
            break;
        case streamingAPIPublicSample:
            urlStr = kStreamingPublicSample;
            requestMethod = SLRequestMethodGET;
        default:
            urlStr = kStreamingUserStreams;
            requestMethod = SLRequestMethodGET;
            break;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    
    SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                            requestMethod:requestMethod
                                                      URL:url
                                               parameters:parameters];
    return request;
}

@end
