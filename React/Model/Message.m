//
//  Message.m
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "Message.h"

@implementation Message

@dynamic owner;
@dynamic media;
@dynamic group;
@dynamic thumb;
@dynamic type;
@dynamic isPrivate;

+ (void)load {
    [self registerSubclass];
}

+ (NSString *)parseClassName {
    return @"Message";
}

- (BOOL)isPhotoMessage {
    return [self.type isEqualToString:MessageTypePhoto];
}

- (BOOL)isVideoMessage {
    return [self.type isEqualToString:MessageTypeVideo];
}


@end
