//
//  Group.h
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import <Parse/Parse.h>

@interface Group : PFObject <PFSubclassing>

@property (nonatomic, strong)   NSArray     *participants;

@end
