//
//  Message.m
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "Message.h"

@implementation Message

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Message";
}

@end
