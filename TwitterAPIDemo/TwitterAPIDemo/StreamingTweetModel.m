//
//  StreamingTweetModel.m
//  TwitterAPIDemo
//
//  Created by Chengzhi Jia on 6/28/16.
//  Copyright © 2016 ChengzhiJia. All rights reserved.
//

#import "StreamingTweetModel.h"

@implementation StreamingTweetModel

- (void)loadTweetObject: (id)JSONObj {
    
    if ([JSONObj isKindOfClass:[NSDictionary class]]) {
        _contributors = [JSONObj objectForKey:@"contributors"];
        _coordinates = [JSONObj objectForKey:@"coordinates"];
        _createDate = [JSONObj objectForKey:@"created_at"];
        _favouriteCount = [[JSONObj objectForKey:@"favorite_count"] integerValue];
        _favourited = [[JSONObj objectForKey:@"favorited"] integerValue];
        _filterLevel = [JSONObj objectForKey:@"filter_level"];
        _geo = [JSONObj objectForKey:@"geo"];
        _idStr = [JSONObj objectForKey:@"id_str"];
        _retweetCount = [[JSONObj objectForKey:@"retweet_count"] integerValue];
        _text = [JSONObj objectForKey:@"text"];
        _timeStamp = [JSONObj objectForKey:@"timestamp_ms"];
    }
    
}

@end
