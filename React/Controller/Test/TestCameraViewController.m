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
#import <AssetsLibrary/AssetsLibrary.h>

@interface TestCameraViewController () <PBJVisionDelegate>

@property (nonatomic, strong)   UIView *previewView;
@property (nonatomic, strong)   AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong)   UILongPressGestureRecognizer *longPress;
@property (nonatomic, assign)   BOOL    isRecording;
@property (nonatomic, strong)   NSMutableArray *moviePlayers;

@end

@implementation TestCameraViewController {
    ALAssetsLibrary *_assetLibrary;
}

- (void)dealloc {

}

- (void)viewDidLoad {
    [super viewDidLoad];

    _assetLibrary = [[ALAssetsLibrary alloc] init];
    // Do any additional setup after loading the view.
    [self setupCameraView];
    [self _setup];
    [[PBJVision sharedInstance] setCameraDevice:PBJCameraDeviceFront];
    self.longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleLongPressGestureRecognizer:)];
    [self.previewView addGestureRecognizer:_longPress];
    self.moviePlayers = [NSMutableArray array];
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
    
    [self performSelectorInBackground:@selector(saveVideoAndPlay:) withObject:videoDict];
}

- (void)saveVideoAndPlay:(NSDictionary*)videoDict {
    NSString *videoPath = [videoDict  objectForKey:PBJVisionVideoPathKey];
    [_assetLibrary writeVideoAtPathToSavedPhotosAlbum:[NSURL URLWithString:videoPath] completionBlock:^(NSURL *assetURL, NSError *error1) {
        [self performSelectorOnMainThread:@selector(playMultipleVideos:) withObject:videoDict waitUntilDone:NO];
    }];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
}

static int i = 0;

- (void)playMultipleVideos:(NSDictionary*)videoDict {
    
    NSURL *video = [NSURL fileURLWithPath:[videoDict objectForKey:PBJVisionVideoPathKey]];
    // Create an AVURLAsset with an NSURL containing the path to the video
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:video options:nil];
    
    // Create an AVPlayerItem using the asset
    AVPlayerItem *playerItem = [AVPlayerItem playerItemWithAsset:asset];
    
    // Create the AVPlayer using the playeritem
    AVPlayer *player = [AVPlayer playerWithPlayerItem:playerItem];
    
    // Create an AVPlayerLayer using the player
    AVPlayerLayer *playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i++ * 60, self.view.bounds.size.height - 100, 50, 50)];
    // Add it to your view's sublayers
    playerLayer.frame = view.bounds;
    [view.layer addSublayer:playerLayer];
    view.layer.cornerRadius = 25;
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    if (i ==1){
        [player play];
    }
    //player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    // You can play/pause using the AVPlayer object
    
    // It is also useful to use the AVPlayerItem's notifications and Key-Value
    // Observing on the AVPlayer's status and the AVPlayerLayer's readForDisplay property
    // (to know when the video is ready to be played, if for example you want to cover the
    // black rectangle with an image until the video is ready to be played)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[player currentItem]];
    
//    [player addObserver:self forKeyPath:@"currentItem.status"
//                options:0
//                context:nil];
//    
//    [playerLayer addObserver:self forKeyPath:@"readyForDisplay"
//                     options:0
//                     context:nil];
    
    [self.moviePlayers addObject:player];
}

- (void)playerItemDidReachEnd:(NSNotification*)notification {
    AVPlayerItem *p = [notification object];
    [p seekToTime:kCMTimeZero];
    
    for (AVPlayer *player in self.moviePlayers) {
        if ([player.currentItem isEqual:p]) {
            [player play];
        }
        else if (player.status == AVPlayerStatusReadyToPlay) {
            [player play];
        }
    }
}

- (void)playMultipleVideosInRepeat:(NSDictionary*)videoDict {
    
    NSURL *video = [NSURL fileURLWithPath:[videoDict objectForKey:PBJVisionVideoPathKey]];
    
    MPMoviePlayerController *controller = [[MPMoviePlayerController alloc] initWithContentURL:video];
    [controller prepareToPlay];
    controller.repeatMode = MPMovieRepeatModeOne;
    controller.controlStyle = MPMovieControlStyleNone;
    controller.view.frame = CGRectMake(i++ * 60, self.view.bounds.size.height - 100, 50, 50);
    [self.view addSubview:controller.view];
    
    [self.moviePlayers addObject:controller];
    controller.view.layer.cornerRadius = 0.5 * 50;
    
    [controller play];
}

- (void)playFullView:(NSDictionary*)videoDict {
    MPMoviePlayerViewController *movieController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL fileURLWithPath:[videoDict objectForKey:PBJVisionVideoPathKey]]];
    [self presentMoviePlayerViewControllerAnimated:movieController];
    movieController.moviePlayer.view.layer.cornerRadius = 0.5 * movieController.moviePlayer.view.bounds.size.width;
    [movieController.moviePlayer play];
}

@end
