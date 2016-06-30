//
//  StreamingTweetModel.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StreamingTweetModel : NSObject

@property (nonatomic, copy, readonly) NSString *contributors;
@property (nonatomic, copy, readonly) NSString *coordinates;
@property (nonatomic, copy, readonly) NSString *createDate;
@property (nonatomic, assign, readonly) NSUInteger favouriteCount;
@property (nonatomic, assign, readonly) NSUInteger favourited;
@property (nonatomic, copy, readonly) NSString *filterLevel;
@property (nonatomic, copy, readonly) NSString *geo;
@property (nonatomic, copy, readonly) NSString *idStr;
@property (nonatomic, assign, readonly) NSUInteger retweetCount;
@property (nonatomic, copy, readonly) NSString *text;
@property (nonatomic, copy, readonly) NSString *timeStamp;

- (void)loadTweetObject: (id)JSONObj;

@end
