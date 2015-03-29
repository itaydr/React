//
//  ParseUtils.m
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "ParseUtils.h"
#import <Parse/Parse.h>
#import <PFFacebookUtils.h>

@implementation ParseUtils

+ (void)initParseWithOptions:(NSDictionary *)launchOptions  {
    
    [Parse setApplicationId:kParseAppId
                  clientKey:kParseClientKey];
    
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    [PFFacebookUtils initializeFacebook];
    
    [User load];
    [Message load];
    [Reaction load];
    [Action load];
    [Channel load];
}

@end
