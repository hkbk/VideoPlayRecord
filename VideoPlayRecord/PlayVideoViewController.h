//
//  PlayVideoViewController.h
//  VideoPlayRecord
//
//  Created by HungNT on 5/28/14.
//  Copyright (c) 2014 HungNT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <MediaPlayer/MediaPlayer.h>

@interface PlayVideoViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

- (IBAction)playVideoBtn:(id)sender;
//Open UIIMagePickerController
-(BOOL)startMediaBrowserFromViewController:(UIViewController *)controller usingDelegate:(id)delegate;
@end
