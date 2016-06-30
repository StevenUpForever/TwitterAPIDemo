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

//Resume/suspend DataTask depends on the UIBarbuttonItem Action

- (void)setControlButtonStatusWithItem: (UIBarButtonItem *)item {
    if ([item.title isEqualToString:@"Stop"]) {
        [self.manager controlDataTaskProcess:NO];
        [item setTitle:@"Resume"];
    } else {
        [self.manager controlDataTaskProcess:YES];
        [item setTitle:@"Stop"];
    }
}

#pragma mark - StreamingAPIDelegate

- (void)didReceiveModelData:(StreamingTweetModel *)model {
    TWTRAPIClient *client = [TWTRAPIClient clientWithCurrentUser];
    if (model.idStr) {
        
        //Load TWTRTweet object depends on id string got, and append it in data source array for dataSource of TableView
        
        [client loadTweetWithID:model.idStr completion:^(TWTRTweet * _Nullable tweet, NSError * _Nullable error) {
            NSMutableArray<TWTRTweet *> *mutableArray = [self.tweetArray mutableCopy];
            if (tweet) {
                [mutableArray addObject:tweet];
            } else {
                
            }
            if (error) {
                NSLog(@"%@", error.localizedDescription);
            }
            self.tweetArray = mutableArray;
            NSLog(@"%@", tweet);
//            NSLog(@"%@", model.idStr);
        }];
    }
}

@end
