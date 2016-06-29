//
//  TwitterStreamingAPIManager.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TwitterStreamingConfiguration.h"

@class StreamingTweetModel;
@protocol StreamingAPIDelegate <NSObject>

@optional
- (void)didFailedConnectToTwitter: (NSString *)errorMessage error: (NSError *)error;

- (void)didReceiveModelData: (StreamingTweetModel *)model;

@end

@interface TwitterStreamingAPIManager : NSObject<NSURLSessionDataDelegate>

@property (weak, nonatomic) id<StreamingAPIDelegate> streamingDelegate;

@property (nonatomic) TwitterStreamingConfiguration *configuration;

- (void)createStreamingConnectionToTwitterWithParameters: (NSDictionary *)paratemers type: (streamingAPIType)type;

@end
