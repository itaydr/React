//
//  User.m
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic profilePic;
@dynamic lastFacebookFriendsFetchDate;
@dynamic displayName;
@dynamic facebookId;

+ (void)load {
    [self registerSubclass];
}

@end
