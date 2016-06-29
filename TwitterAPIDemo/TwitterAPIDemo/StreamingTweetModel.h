//
//  StreamingTweetModel.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StreamingTweetModel : NSObject

@property (nonatomic, copy) NSString *contributors;
@property (nonatomic, copy) NSString *coordinates;
@property (nonatomic, copy) NSString *createDate;
@property (nonatomic, assign) NSUInteger favouriteCount;
@property (nonatomic, assign) NSUInteger favourited;
@property (nonatomic, copy) NSString *filterLevel;
@property (nonatomic, copy) NSString *geo;
@property (nonatomic, copy) NSString *idStr;
@property (nonatomic, assign) NSUInteger retweetCount;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *timeStamp;

- (void)loadTweetObject: (id)JSONObj;

@end
