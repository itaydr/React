//
//  Message.h
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import <Parse/Parse.h>
#import "Group.h"

#define MessageTypeVideo  @"video"
#define MessageTypePhoto  @"photo"

@interface Message : PFObject <PFSubclassing>

@property (nonatomic, strong)   User        *owner;
@property (nonatomic, strong)   PFFile      *media;
@property (nonatomic, strong)   Group       *group;
@property (nonatomic, strong)   PFFile      *thumb;
@property (nonatomic, strong)   NSString    *type;
@property (nonatomic, assign)   BOOL        isPrivate;

- (BOOL)isVideoMessage;
- (BOOL)isPhotoMessage;

@end
