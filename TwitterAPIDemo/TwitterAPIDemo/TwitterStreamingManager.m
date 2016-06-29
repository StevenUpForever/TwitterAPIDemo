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
    }
    return self;
}

- (void)loadTWTRSession: (TWTRSession *)session {
    _userID = session.userID;
    _userName = session.userName;
}

- (void)createStreamingConnectionToTwitterWithParameters: (NSDictionary *)paratemers type: (streamingAPIType)type {
    ACAccountStore *store = [[ACAccountStore alloc]init];
    ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [store requestAccessToAccountsWithType:twitterAccountType options:nil completion:^(BOOL granted, NSError *error) {
        if (error) {
            
            //Error when trying to enter the twitter account
            if ([self.streamingDelegate respondsToSelector:@selector(didFailedConnectToTwitter:error:)]) {
                [self.streamingDelegate didFailedConnectToTwitter:error.localizedDescription error:error];
            }
            
        } else if (!granted) {
            
            if ([self.streamingDelegate respondsToSelector:@selector(didFailedConnectToTwitter:error:)]) {
                [self.streamingDelegate didFailedConnectToTwitter:@"Twitter access not granted" error:nil];
            }
            
        } else {
            NSArray *accountArray = [store accountsWithAccountType:twitterAccountType];
            if (accountArray.count > 0) {
                
                ACAccount *account = [accountArray lastObject];
                //                NSLog(@"%@", account.userFullName);
                SLRequest *request = [self.configuration createURLRequestWithParameters:paratemers type:type];
                [request setAccount:account];
                NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
                NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[request preparedURLRequest]];
                [dataTask resume];
            } else {
                if ([self.streamingDelegate respondsToSelector:@selector(didFailedConnectToTwitter:error:)]) {
                    [self.streamingDelegate didFailedConnectToTwitter:@"No Twitter account available" error:nil];
                }
            }
        }
    }];
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

@end