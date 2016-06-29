//
//  MainViewModel.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "MainViewModel.h"
#import <TwitterKit/Twitter.h>
#import "TwitterSessionManager.h"
#import "TwitterStreamingManager.h"

@interface MainViewModel()

@property (nonatomic) TwitterStreamingManager *streamingManager;

@property (nonatomic) ACAccount *account;

@end

@implementation MainViewModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _streamingManager = [TwitterStreamingManager sharedManager];
    }
    return self;
}

- (void)checkTwitterAvailableWithCallBack: (void(^)(BOOL success, NSString *errorMessage))callback {
    [TwitterSessionManager checkTwitterAccountAvailabilityWithSuccessHandler:^(BOOL loggedIn, NSArray *accountArray) {
        if (!loggedIn) {
            Twitter *twitter = [Twitter sharedInstance];
            [twitter logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
                if (session) {
                    if (callback) {
                        if (accountArray.count > 0) {
                            self.account = accountArray.lastObject;
                        }
                        callback(YES, nil);
                    }
                } else {
                    if (callback) {
                        callback(NO, @"Failed to login");
                    }
                }
            }];
        } else {
            if (callback) {
                if (accountArray.count > 0) {
                    self.account = accountArray.lastObject;
                }
                callback(YES, nil);
            }
        }
        
    } failureHandler:^(NSString *errorMessage) {
        if (callback) {
            callback(NO, errorMessage);
        }
    }];
}

//Create related parameter dictionary and set it along with type to a new Configuration object and dispatch it to sharedInstance of streamingManagerObject

- (void)createStreamingManagerConfigurationWithSourceTitle: (NSString *)title follow: (NSString *)follow track: (NSString *)track locations: (NSString *)locations {
    NSDictionary *parameters = [TwitterStreamingConfiguration postParameterWithFollow:follow track:track locations:locations];
    self.streamingManager.configuration = [[TwitterStreamingConfiguration alloc]initWithType:[self SourceURLChooseWithTitle:title] parameters:parameters account:self.account];
}

#pragma mark - private methods

- (streamingAPIType)SourceURLChooseWithTitle: (NSString *)title {
    if ([title isEqualToString:@"Public API with filter"]) {
        return streamingAPIPublicFilter;
    } else if ([title isEqualToString:@"Public API with Samples"]) {
        return streamingAPIPublicSample;
    } else {
       return streamingAPIUserStreams;
    }
}

@end
