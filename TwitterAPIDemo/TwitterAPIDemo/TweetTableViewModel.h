//
//  TweetTableViewModel.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TWTRTweet;
@interface TweetTableViewModel : NSObject

@property (nonatomic, copy) NSArray<TWTRTweet *> *tweetArray;

- (void)beginReceivingData;

@end
