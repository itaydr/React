//
//  LoginViewController.m
//  React
//
//  Created by Itay Dressler on 3/22/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@implementation LoginViewController

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.fields = PFLogInFieldsFacebook;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

@end
