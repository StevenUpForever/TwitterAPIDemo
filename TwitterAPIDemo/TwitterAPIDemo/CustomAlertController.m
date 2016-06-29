//
//  CustomViewController.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "CustomAlertController.h"

@interface CustomAlertController ()

@end

@implementation CustomAlertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)showCancelAlertController: (NSString *)title message: (NSString *)message target: (__kindof UIViewController *)target {
    UIAlertController *alertController = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil]];
    [target presentViewController:alertController animated:YES completion:nil];
}

+ (void)showActionSheetWithTitle: (NSString *)title message: (NSString *)message contents: (NSArray<NSString *> *)contents action: (void(^)(UIAlertAction *action))actionHandler target: (__kindof UIViewController *)target {
    UIAlertController *alertController = [self alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    for (NSString *str in contents) {
        [alertController addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            actionHandler(action);
        }]];
    }
    [target presentViewController:alertController animated:YES completion:nil];
}

@end
