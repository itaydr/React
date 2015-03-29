//
//  Channel.m
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "Channel.h"

@implementation Channel

@dynamic displayName;
@dynamic backgroundImage;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Channel";
}

@end
