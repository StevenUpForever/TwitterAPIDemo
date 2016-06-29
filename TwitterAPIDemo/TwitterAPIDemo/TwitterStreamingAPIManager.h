//
//  TwitterStreamingAPIManager.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol StreamingAPIDelegate <NSObject>

@optional
- (void)didFailedConnectToTwitter: (NSString *)errorMessage error: (NSError *)error;

@end

@interface TwitterStreamingAPIManager : NSObject<NSURLSessionDataDelegate>

@property (weak, nonatomic) id<StreamingAPIDelegate> streamingDelegate;

@end
