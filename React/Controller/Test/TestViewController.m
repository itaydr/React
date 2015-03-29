//
//  TestViewController.m
//  React
//
//  Created by Itay Dressler on 3/25/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "TestViewController.h"
#import <Parse/Parse.h>
#import <ParseUI.h>
#import "LoginViewController.h"

@interface TestViewController () <PFLogInViewControllerDelegate>

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (![PFUser currentUser]) {
        [self performSegueWithIdentifier:@"login" sender:nil];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.destinationViewController isKindOfClass:[LoginViewController class]]) {
        [(PFLogInViewController*)segue.destinationViewController setDelegate:self];
    }
}

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    if ([User currentUser]) {
        [[User currentUser] registerFacebookFriends];
    }
    [logInController dismissViewControllerAnimated:YES completion:nil];
}

@end
