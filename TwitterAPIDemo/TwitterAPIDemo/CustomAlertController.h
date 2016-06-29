//
//  CustomViewController.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertController : UIAlertController

/*Custom alertView with only cancel button*/

+ (void)showCancelAlertController: (NSString *)title message: (NSString *)message target: (__kindof UIViewController *)target;

/*Custom ActionSheet with same action for each UIAlertAction*/

+ (void)showActionSheetWithTitle: (NSString *)title message: (NSString *)message contents: (NSArray<NSString *> *)contents action: (void(^)(UIAlertAction *action))actionHandler target: (__kindof UIViewController *)target;

@end
