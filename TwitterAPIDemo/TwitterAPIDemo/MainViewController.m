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

//Container view contains all parameters textFields which will be hidden when source is not filter

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end

@implementation MainViewController

//Check twitter availability in viewDidLoad and submit parameters

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

#pragma mark - Selectors

- (IBAction)sourceLabelTap:(UITapGestureRecognizer *)sender {
    [CustomAlertController showActionSheetWithTitle:nil message:@"Choose URL Source" contents:@[@"Public API with filter", @"Public API with Samples", @"Authorized user API"] action:^(UIAlertAction *action) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            self.sourceLabel.text = action.title;
            self.containerView.hidden = ![self.sourceLabel.text isEqualToString:@"Public API with filter"];
        });
        
    } target:self];
}


#pragma mark - private methods

//Common method to check Twitter Account availability when initial the viewController or submit parameters

- (void)viewModelCheckTwitterAndLogin: (BOOL)login {
    [self.viewModel checkTwitterAvailableWithCallBack:^(BOOL success, NSString *errorMessage) {
        if (!success) {
            [CustomAlertController showCancelAlertController:@"error" message:errorMessage target:self];
        } else {
            if (login) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.viewModel createStreamingManagerConfigurationWithSourceTitle:self.sourceLabel.text follow:self.followTextField.text track:self.trackTextField.text locations:self.locationTextField.text];
                    [self performSegueWithIdentifier:@"TWTRAPIClient" sender:self];
                });
            }
        }
    }];
}

@end
