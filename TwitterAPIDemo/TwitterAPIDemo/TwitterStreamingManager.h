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
- (void)didFailedConnectToTwitter: (NSString *)errorMessage error: (NSError *)error;

- (void)didReceiveModelData: (StreamingTweetModel *)model;

@end
@interface TwitterStreamingManager : NSObject<NSURLSessionDataDelegate>

@property (weak, nonatomic) id<StreamingAPIDelegate> streamingDelegate;

@property (nonatomic, copy, readonly) NSString *userID;
@property (nonatomic, copy, readonly) NSString *userName;

@property (nonatomic) TwitterStreamingConfiguration *configuration;

+ (TwitterStreamingManager *)sharedManager;

- (void)loadTWTRSession: (TWTRSession *)session;

- (void)createStreamingConnectionToTwitterWithParameters: (NSDictionary *)paratemers type: (streamingAPIType)type;

@end
