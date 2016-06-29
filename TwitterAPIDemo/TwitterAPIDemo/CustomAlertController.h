//
//  CustomViewController.h
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomAlertController : UIAlertController

+ (void)showCancelAlertController: (NSString *)title message: (NSString *)message target: (__kindof UIViewController *)target;

@end
