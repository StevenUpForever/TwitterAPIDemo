//
//  TwitterSessionManager.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "TwitterSessionManager.h"
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@implementation TwitterSessionManager

+ (void)checkTwitterAccountAvailabilityWithSuccessHandler: (void(^)(BOOL loggedIn, NSArray *accountArray))successHandler failureHandler: (void(^)(NSString *errorMessage))failureHandler {
    ACAccountStore *store = [[ACAccountStore alloc]init];
    ACAccountType *twitterAccountType = [store accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    [store requestAccessToAccountsWithType:twitterAccountType options:nil completion:^(BOOL granted, NSError *error) {
        if (error) {
            
            if (failureHandler) {
                failureHandler(error.localizedDescription);
            }
            
        } else if (!granted) {
            
            if (failureHandler) {
                failureHandler(@"Twitter account not granted");
            }
            
        } else {
            NSArray *accountArray = [store accountsWithAccountType:twitterAccountType];
            if (accountArray.count > 0) {
                //                ACAccount *account = [accountArray lastObject];
                //                //                NSLog(@"%@", account.userFullName);
                //                SLRequest *request = [self.configuration createURLRequestWithParameters:paratemers type:type];
                //                [request setAccount:account];
                //                NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
                //                NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:[request preparedURLRequest]];
                //                [dataTask resume];
                if (successHandler) {
                    successHandler(YES, accountArray);
                }
            } else {
                if (successHandler) {
                    successHandler(NO, accountArray);
                }
            }
        }
    }];
}


@end
