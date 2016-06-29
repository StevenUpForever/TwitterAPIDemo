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

@implementation MainViewModel

- (void)checkTwitterAvailableWithCallBack: (void(^)(BOOL success, NSString *errorMessage))callback {
    [TwitterSessionManager checkTwitterAccountAvailabilityWithSuccessHandler:^(BOOL loggedIn, NSArray *accountArray) {
        if (!loggedIn) {
            Twitter *twitter = [Twitter sharedInstance];
            [twitter logInWithCompletion:^(TWTRSession * _Nullable session, NSError * _Nullable error) {
                TwitterStreamingManager *streamingManager = [TwitterStreamingManager sharedManager];
                if (session) {
                    [streamingManager loadTWTRSession:session];
                    if (callback) {
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
                callback(YES, nil);
            }
        }
        
    } failureHandler:^(NSString *errorMessage) {
        if (callback) {
            callback(NO, errorMessage);
        }
    }];
}

@end
