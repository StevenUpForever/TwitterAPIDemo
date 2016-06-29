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

@property (nonatomic, assign) streamingAPIType sourceType;
@property (nonatomic, copy) NSDictionary *parameters;
@property (nonatomic) ACAccount *account;

@end

@implementation TwitterStreamingConfiguration

- (instancetype)initWithType: (streamingAPIType)type parameters: (NSDictionary *)parameters account: (ACAccount *)account
{
    self = [super init];
    if (self) {
        _sourceType = type;
        _parameters = parameters;
        _account = account;
    }
    return self;
}

+ (NSDictionary *)postParameterWithFollow: (NSString *)follow track: (NSString *)track locations: (NSString *)locations {
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc]init];
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

- (NSURLRequest *)createURLRequest {
    NSString *urlStr;
    switch (self.sourceType) {
        case streamingAPIPublicFilter:
            urlStr = kStreamingPulicFilter;
            break;
        case streamingAPIPublicSample:
            urlStr = kStreamingPublicSample;
        default:
            urlStr = kStreamingUserStreams;
            break;
    }
    NSURL *url = [NSURL URLWithString:urlStr];
    
    SLRequest *request;
    if (self.sourceType == streamingAPIPublicFilter) {
        request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                     requestMethod:SLRequestMethodPOST
                                               URL:url
                                        parameters:self.parameters];
    } else {
        request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                     requestMethod:SLRequestMethodGET
                                               URL:url
                                        parameters:nil];
    }
    [request setAccount:self.account];
    return [request preparedURLRequest];
}

@end
