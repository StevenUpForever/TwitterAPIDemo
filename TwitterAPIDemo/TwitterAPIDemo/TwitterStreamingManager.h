//
//  TwitterStreamingManager.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterStreamingConfiguration.h"

@class StreamingTweetModel;
@class TWTRSession;
@protocol StreamingAPIDelegate <NSObject>

@optional

- (void)didReceiveModelData: (StreamingTweetModel *)model;

@end
@interface TwitterStreamingManager : NSObject<NSURLSessionDataDelegate>

@property (weak, nonatomic) id<StreamingAPIDelegate> streamingDelegate;

@property (nonatomic) TwitterStreamingConfiguration *configuration;

+ (TwitterStreamingManager *)sharedManager;

/* Datatask and Connection lifeCycle management */

- (void)createStreamingConnectionToTwitter;
- (void)cancelSession;
- (void)controlDataTaskProcess: (BOOL)currentSuspended;

@end
