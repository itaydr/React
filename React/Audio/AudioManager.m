//
//  AudioManager.m
//  React
//
//  Created by Itay Dressler on 3/28/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "AudioManager.h"
#import <AEAudioController.h>

@interface AudioManager ()

@property (nonatomic, strong)   AEAudioController *audioController;

@end

static AudioManager *SHARED_INSTANCE;

@implementation AudioManager

+ (AudioManager*)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SHARED_INSTANCE = [[AudioManager alloc] init];
    });
    
    return SHARED_INSTANCE;
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupAudioController];
    }
    
    return self;
}

- (void)setupAudioController {
    self.audioController = [[AEAudioController alloc] initWithAudioDescription:[AEAudioController nonInterleaved16BitStereoAudioDescription]
                                                                  inputEnabled:YES
                                                            useVoiceProcessing:YES];

}

- (void)startRunning {
    NSError *error = NULL;
    BOOL result = [self.audioController start:&error];
    if ( !result ) {
        NSLog(@"Failed starting the audio session: %@", error);
    }
}

@end
