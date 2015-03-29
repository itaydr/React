//
//  CreationViewController.m
//  React
//
//  Created by Itay Dressler on 3/29/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "CreationViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>

@interface CreationViewController () <UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@end

@implementation CreationViewController
- (IBAction)importMediaPressed:(id)sender {
    [self displayMediaPicker];
}

#pragma mark UIImagePickerController

- (void)displayMediaPicker {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType   = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.mediaTypes   =[[NSArray alloc] initWithObjects: (NSString *)kUTTypeMovie,nil];
    picker.delegate     = self;
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
    
    if (CFStringCompare ((__bridge CFStringRef) mediaType, kUTTypeMovie, 0) == kCFCompareEqualTo) {
        NSURL *videoUrl=(NSURL*)[info objectForKey:UIImagePickerControllerMediaURL];
        NSString *moviePath = [videoUrl path];
        
        // Temp - saving video
        if (UIVideoAtPathIsCompatibleWithSavedPhotosAlbum (moviePath)) {
            UISaveVideoAtPathToSavedPhotosAlbum (moviePath, nil, nil, nil);
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
