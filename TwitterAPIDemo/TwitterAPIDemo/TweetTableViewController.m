//
//  TweetTableViewController.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/29/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "TweetTableViewController.h"
#import "TweetTableViewModel.h"
#import <TwitterKit/TwitterKit.h>

@interface TweetTableViewController ()

@property (nonatomic) TweetTableViewModel *viewModel;

@end

@implementation TweetTableViewController

#pragma mark - viewController lifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewModel = [[TweetTableViewModel alloc]init];
    [self.viewModel addObserver:self forKeyPath:@"tweetArray" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    [self.viewModel beginReceivingData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [self.viewModel stopReceivingData];
    [self.viewModel removeObserver:self forKeyPath:@"tweetArray"];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.tweetArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TWTRTweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"tweetCell"];
    [cell configureWithTweet:self.viewModel.tweetArray[indexPath.row]];
    cell.tweetView.showActionButtons = YES;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [TWTRTweetTableViewCell heightForTweet:self.viewModel.tweetArray[indexPath.row] style:TWTRTweetViewStyleCompact width:self.view.bounds.size.width showingActions:YES];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"tweetArray"] && self.viewModel.tweetArray.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.viewModel.tweetArray.count - 1 inSection:0];
        [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
