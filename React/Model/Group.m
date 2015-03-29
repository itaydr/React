//
//  Group.m
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "Group.h"

@implementation Group

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Group";
}

@end
