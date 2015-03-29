//
//  User.h
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import <Parse/Parse.h>

@interface User : PFUser <PFSubclassing>

@property (strong, nonatomic) NSString                      *facebookId;
@property (strong, nonatomic) NSString                      *displayName;
@property (strong, nonatomic) PFFile                        *profilePic;
@property (nonatomic, strong) NSDate                        *lastFacebookFriendsFetchDate;

@end
