//
//  ViewController.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "MainViewController.h"
#import "MainViewModel.h"
#import "CustomButton.h"
#import "CustomLabel.h"
#import "CustomAlertController.h"

@interface MainViewController ()

@property (nonatomic) MainViewModel *viewModel;

@property (weak, nonatomic) IBOutlet CustomLabel *sourceLabel;
@property (weak, nonatomic) IBOutlet UITextField *followTextField;
@property (weak, nonatomic) IBOutlet UITextField *trackTextField;
@property (weak, nonatomic) IBOutlet UITextField *locationTextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[MainViewModel alloc]init];
    [self viewModelCheckTwitterAndLogin:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)submitAction:(CustomButton *)sender {
    [self viewModelCheckTwitterAndLogin:YES];
}

#pragma mark - private methods

- (void)viewModelCheckTwitterAndLogin: (BOOL)login {
    [self.viewModel checkTwitterAvailableWithCallBack:^(BOOL success, NSString *errorMessage) {
        if (!success) {
            [CustomAlertController showCancelAlertController:@"error" message:errorMessage target:self];
        } else {
            if (login) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self performSegueWithIdentifier:@"TWTRAPIClient" sender:self];
                });
            }
        }
    }];
}

@end
