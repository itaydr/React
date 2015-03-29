//
//  User.m
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "User.h"
#import <PFFacebookUtils.h>

@implementation User

@dynamic profilePic;
@dynamic lastFacebookFriendsFetchDate;
@dynamic displayName;
@dynamic facebookId;

+ (void)load {
    [self registerSubclass];
}

- (void)registerFacebookFriends {
    FBRequest *friendsRequest = [FBRequest requestForMyFriends];
    [friendsRequest startWithCompletionHandler: ^(FBRequestConnection *connection,
                                                  NSDictionary* result,
                                                  NSError *error) {
        
        if (error) {
            NSLog(@"Failed to fetch friends - %@", error);
            return;
        }
        
        NSArray *friends = result[@"data"];
        NSMutableArray *facebookIds = [NSMutableArray array];
        for (NSDictionary<FBGraphUser>* friend in friends) {
            [facebookIds addObject:[NSString stringWithFormat:@"%@",friend[@"id"]]];
        }
        
        NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:facebookIds, @"facebook_ids" , nil];
        
        [PFCloud callFunctionInBackground:@"" withParameters:params block:^(id object, NSError *error) {
            if (error) {
                NSLog(@"Failed to register friends");
            }
            else {
                NSLog(@"Successfully registered friends");
            }
        } ];
    }];
}

@end
