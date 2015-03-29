//
//  Reaction.h
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import <Parse/Parse.h>

@interface Reaction : PFObject <PFSubclassing>

@property (nonatomic, strong)   User        *from;
@property (nonatomic, strong)   Message     *to;
@property (nonatomic, strong)   PFFile      *media;
@property (nonatomic, strong)   PFFile      *thumb;

@end
