//
//  ViewController.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"
#import "CustomAlertController.h"

@interface MainViewController ()

@property (nonatomic) MainViewModel *viewModel;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[MainViewModel alloc]init];
    [self.viewModel checkTwitterAvailableWithCallBack:^(BOOL success, NSString *errorMessage) {
        if (!success) {
            [CustomAlertController showCancelAlertController:@"error" message:errorMessage target:self];
        } else {
            [self performSegueWithIdentifier:@"TWTRAPIClient" sender:self];
        }
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
