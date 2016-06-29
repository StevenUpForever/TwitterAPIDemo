//
//  TwitterStreamingManager.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "TwitterStreamingManager.h"
#import "StreamingTweetModel.h"
#import <TwitterCore/TwitterCore.h>

@interface TwitterStreamingManager()

@property (nonatomic) NSURLSession *session;
@property (nonatomic) NSURLSessionDataTask *dataTask;

@end

@implementation TwitterStreamingManager

+ (TwitterStreamingManager *)sharedManager {
    static dispatch_once_t onceToken;
    static TwitterStreamingManager *manager;
    dispatch_once(&onceToken, ^{
        manager = [[TwitterStreamingManager alloc]init];
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _configuration = [[TwitterStreamingConfiguration alloc]init];
        _session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
    }
    return self;
}

- (void)createStreamingConnectionToTwitter {
    NSURLSessionDataTask *dataTask = [self.session dataTaskWithRequest:[self.configuration createURLRequest]];
    [dataTask resume];
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    id dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    //    NSLog(@"%@", dict);
    StreamingTweetModel *model = [[StreamingTweetModel alloc]init];
    [model loadTweetObject:dict];
    if ([self.streamingDelegate respondsToSelector:@selector(didReceiveModelData:)]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.streamingDelegate didReceiveModelData:model];
        });
    }
}

- (void)cancelSession {
    [self.dataTask cancel];
    [self.session finishTasksAndInvalidate];
}

@end
