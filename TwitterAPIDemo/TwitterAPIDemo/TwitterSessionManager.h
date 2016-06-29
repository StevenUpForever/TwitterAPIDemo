//
//  TwitterSessionManager.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TwitterSessionManager : NSObject

+ (void)checkTwitterAccountAvailabilityWithSuccessHandler: (void(^)(BOOL loggedIn, NSArray *accountArray))successHandler failureHandler: (void(^)(NSString *errorMessage))failureHandler;

@end
