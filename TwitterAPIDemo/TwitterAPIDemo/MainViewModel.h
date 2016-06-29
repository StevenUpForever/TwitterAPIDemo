//
//  MainViewModel.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewModel : NSObject

- (void)checkTwitterAvailableWithCallBack: (void(^)(BOOL success, NSString *errorMessage))callback;

@end
