//
//  AudioManager.h
//  React
//
//  Created by Itay Dressler on 3/28/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioManager : NSObject

+ (AudioManager*)sharedManager;
- (void)startRunning;

@end
