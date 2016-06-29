//
//  TwitterStreamingAPIManager.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "TwitterStreamingAPIManager.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@implementation TwitterStreamingAPIManager

- (void)createStreamingConnectionToTwitterWithType: (streamingAPIType)type {
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
                NSURL *url = [NSURL URLWithString:@"https://stream.twitter.com/1.1/statuses/filter.json"];
                NSDictionary *params = @{@"track" : @"twitter"};
                
                SLRequest *request = [SLRequest requestForServiceType:SLServiceTypeTwitter
                                                        requestMethod:SLRequestMethodPOST
                                                                  URL:url
                                                           parameters:params];
                
                [request setAccount:account];
                
                // Once we have the authenticated request prepared, we launch the session
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSLog(@"Connection");
                    //                        self.connection = [NSURLConnection connectionWithRequest:[request preparedURLRequest] delegate:self];
                    //                        [self.connection start];
                    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
                    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[request preparedURLRequest]];
                    [dataTask resume];
                });
            } else {
                if ([self.streamingDelegate respondsToSelector:@selector(didFailedConnectToTwitter:error:)]) {
                    [self.streamingDelegate didFailedConnectToTwitter:@"No Twitter account available" error:nil];
                }
            }
        }
    }];
}

#pragma mark - private methods

- (NSURLRequest *)configureURLRequestWithType: (streamingAPIType)type {
    
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data {
    
}

@end