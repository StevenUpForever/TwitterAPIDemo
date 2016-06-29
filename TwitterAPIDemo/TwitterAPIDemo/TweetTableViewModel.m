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

@property (nonatomic) TwitterStreamingManager *manager;

@end

@implementation TweetTableViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tweetArray = [[NSArray alloc]init];
        _manager = [TwitterStreamingManager sharedManager];
        _manager.streamingDelegate = self;
    }
    return self;
}

- (void)beginReceivingData {
    [self.manager createStreamingConnectionToTwitter];
}

- (void)stopReceivingData {
    [self.manager cancelSession];
}

#pragma mark - StreamingAPIDelegate

- (void)didReceiveModelData:(StreamingTweetModel *)model {
    TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
    if (model.idStr) {
        [client loadTweetWithID:model.idStr completion:^(TWTRTweet * _Nullable tweet, NSError * _Nullable error) {
            NSMutableArray<TWTRTweet *> *mutableArray = [self.tweetArray mutableCopy];
            if (tweet) {
                [mutableArray addObject:tweet];
            } else {
                
            }
            self.tweetArray = mutableArray;
            NSLog(@"%@", tweet);
//            NSLog(@"%@", model.idStr);
        }];
    }
}

@end
