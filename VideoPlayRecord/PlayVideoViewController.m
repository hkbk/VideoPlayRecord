//
//  PlayVideoViewController.m
//  VideoPlayRecord
//
//  Created by HungNT on 5/28/14.
//  Copyright (c) 2014 HungNT. All rights reserved.
//

#import "PlayVideoViewController.h"

@interface PlayVideoViewController ()

@end

@implementation PlayVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)playVideoBtn:(id)sender {
    [self startMediaBrowserFromViewController:self usingDelegate:self];
}

-(BOOL)startMediaBrowserFromViewController:(UIViewController *)controller usingDelegate:(id)delegate
{
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum] == NO || (delegate == nil)
        || (controller == nil)) {
        return NO;
    }
    //get image Picker
    UIImagePickerController *mediaUI = [[UIImagePickerController alloc]init];
    mediaUI.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    mediaUI.mediaTypes = [[NSArray alloc]initWithObjects:(NSString *)kUTTypeMovie, nil];
    mediaUI.allowsEditing =YES;
    mediaUI.delegate = delegate;
    [controller presentViewController:mediaUI animated:YES completion:nil];
    
    return YES;
}

#pragma mark - UIIamgePicker Delegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissViewControllerAnimated:NO completion:nil];
    //handle a movie capture
    if (CFStringCompare((__bridge CFStringRef)(mediaType), kUTTypeMovie, 0) == kCFCompareEqualTo) {
        //play movie
        MPMoviePlayerViewController *playMovie = [[MPMoviePlayerViewController alloc] initWithContentURL:[info objectForKey:UIImagePickerControllerMediaURL]];
        [self presentViewController:playMovie animated: YES completion:nil];
       
        // notification play finish
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(myMovieFinishCallBack:) name:MPMoviePlayerPlaybackDidFinishNotification object:playMovie];
        
    }
}

-(void)myMovieFinishCallBack:(NSNotification  *)aNotification
{
    [self dismissMoviePlayerViewControllerAnimated];
    
    MPMoviePlayerController *moviePlayer = [aNotification object];
    //remove notification.
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:moviePlayer];
    
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
