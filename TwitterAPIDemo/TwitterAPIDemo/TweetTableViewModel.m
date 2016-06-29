//
//  TweetTableViewModel.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "TweetTableViewModel.h"
#import "StreamingTweetModel.h"
#import "TwitterStreamingAPIManager.h"
#import <TwitterKit/TwitterKit.h>

@interface TweetTableViewModel()<StreamingAPIDelegate>

@end

@implementation TweetTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tweetArray = [[NSArray alloc]init];
    }
    return self;
}

- (void)beginReceivingData {
    TwitterStreamingAPIManager *manager = [[TwitterStreamingAPIManager alloc]init];
    manager.streamingDelegate = self;
    NSDictionary *parameters = [manager.configuration postParameterWithFollow:nil track:@"girl" locations:nil delimited:NO warnings:NO];
    [manager createStreamingConnectionToTwitterWithParameters:parameters type:streamingAPIUserStreams];
}

- (void)didReceiveModelData:(StreamingTweetModel *)model {
    TWTRAPIClient *client = [[TWTRAPIClient alloc]initWithUserID:@"28663631"];
    [client loadTweetWithID:model.idStr completion:^(TWTRTweet * _Nullable tweet, NSError * _Nullable error) {
        NSMutableArray<TWTRTweet *> *mutableArray = [self.tweetArray mutableCopy];
        [mutableArray addObject:tweet];
        self.tweetArray = mutableArray;
        NSLog(@"%i", self.tweetArray.count);
    }];
}

@end
