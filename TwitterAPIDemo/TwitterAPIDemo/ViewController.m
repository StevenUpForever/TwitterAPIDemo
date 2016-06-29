//
//  ViewController.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "ViewController.h"
#import "TwitterStreamingAPIManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    TwitterStreamingAPIManager *manager = [[TwitterStreamingAPIManager alloc]init];
    NSDictionary *parameters = [manager.configuration postParameterWithFollow:nil track:@"girl" locations:nil delimited:NO warnings:NO];
    [manager createStreamingConnectionToTwitterWithParameters:parameters type:streamingAPIUserStreams];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
