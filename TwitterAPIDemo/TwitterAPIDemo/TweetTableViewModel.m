//
//  TweetTableViewModel.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "TweetTableViewModel.h"
#import "StreamingTweetModel.h"
#import "TwitterStreamingManager.h"
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
    TwitterStreamingManager *manager = [[TwitterStreamingManager alloc]init];
    manager.streamingDelegate = self;
    NSDictionary *parameters = [manager.configuration postParameterWithFollow:nil track:@"NBA" locations:nil delimited:NO warnings:NO];
    [manager createStreamingConnectionToTwitterWithParameters:parameters type:streamingAPIPublicFilter];
}

#pragma mark - StreamingAPIDelegate

- (void)didReceiveModelData:(StreamingTweetModel *)model {
    TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
    if (model.idStr) {
        [client loadTweetWithID:model.idStr completion:^(TWTRTweet * _Nullable tweet, NSError * _Nullable error) {
            NSMutableArray<TWTRTweet *> *mutableArray = [self.tweetArray mutableCopy];
            if (tweet) {
                [mutableArray addObject:tweet];
            }
            self.tweetArray = mutableArray;
            NSLog(@"%@", tweet);
            NSLog(@"%@", model.idStr);
        }];
    }
}

@end
