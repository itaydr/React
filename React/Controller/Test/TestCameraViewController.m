//
//  TestCameraViewController.m
//  React
//
//  Created by Itay Dressler on 3/25/15.
//  Copyright (c) 2015 react. All rights reserved.
//

#import "TestCameraViewController.h"
#import <PBJVision.h>
#import <MediaPlayer/MediaPlayer.h>

@interface TestCameraViewController () <PBJVisionDelegate>

@property (nonatomic, strong)   UIView *previewView;
@property (nonatomic, strong)   AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong)   UILongPressGestureRecognizer *longPress;
@property (nonatomic, assign)   BOOL    isRecording;

@end

@implementation TestCameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupCameraView];
    [self _setup];
    [[PBJVision sharedInstance] setCameraDevice:PBJCameraDeviceFront];
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
    [self.previewView addGestureRecognizer:_longPress];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)stopPressed:(id)sender {
    [[PBJVision sharedInstance] endVideoCapture];
}

- (void)handleLongPressGestureRecognizer:(UIGestureRecognizer *)gestureRecognizer
{
    switch (gestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            if (!self.isRecording) {
                [[PBJVision sharedInstance] startVideoCapture];
                self.isRecording = YES;
            }
            else
                [[PBJVision sharedInstance] resumeVideoCapture];
            break;
        }
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:
        case UIGestureRecognizerStateFailed:
        {
            [[PBJVision sharedInstance] pauseVideoCapture];
            break;
        }
        default:
            break;
    }
}

- (void)setupCameraView {
    // preview and AV layer
    _previewView = [[UIView alloc] initWithFrame:CGRectZero];
    _previewView.backgroundColor = [UIColor blackColor];
    CGRect previewFrame = CGRectMake(0, 60.0f, CGRectGetWidth(self.view.frame), CGRectGetWidth(self.view.frame));
    _previewView.frame = previewFrame;
    _previewLayer = [[PBJVision sharedInstance] previewLayer];
    _previewLayer.frame = _previewView.bounds;
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [_previewView.layer addSublayer:_previewLayer];
    _previewLayer.cornerRadius = 0.5 * _previewLayer.bounds.size.width;
    [self.view addSubview:self.previewView];
    _previewView.backgroundColor = [UIColor clearColor];
}

- (void)_setup
{
    //_longPressGestureRecognizer.enabled = YES;
    
    PBJVision *vision = [PBJVision sharedInstance];
    vision.delegate = self;
    vision.cameraMode = PBJCameraModeVideo;
    vision.cameraOrientation = PBJCameraOrientationPortrait;
    vision.focusMode = PBJFocusModeContinuousAutoFocus;
    vision.outputFormat = PBJOutputFormatSquare;
    
    [vision startPreview];
}

- (void)vision:(PBJVision *)vision capturedVideo:(NSDictionary *)videoDict error:(NSError *)error {
    NSLog(@"Finished video capture");
    self.isRecording = NO;
    MPMoviePlayerViewController *movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:[videoDict objectForKey:PBJVisionVideoPathKey]]];
    [self presentMoviePlayerViewControllerAnimated:movieController];
    movieController.moviePlayer.view.layer.cornerRadius = 0.5 * movieController.moviePlayer.view.bounds.size.width;
    [movieController.moviePlayer play];
}

@end
