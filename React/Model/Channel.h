//
//  Channel.h
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import <Parse/Parse.h>

@interface Channel : PFObject <PFSubclassing>

@property (nonatomic, strong)   NSString        *displayName;
@property (nonatomic, strong)   PFFile          *backgroundImage;

@end
