//
//  INFirstViewController.h
//  IndiaSearch
//
//  Created by Manu Sharma on 1/15/13.
//  Copyright (c) 2013 Manu Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import <QuartzCore/QuartzCore.h>



@interface INFirstViewController : UIViewController <UIApplicationDelegate, UITableViewDataSource,
FBFriendPickerDelegate,
UINavigationControllerDelegate,
FBPlacePickerDelegate,
CLLocationManagerDelegate,
UIActionSheetDelegate>

@property (strong, nonatomic) FBUserSettingsViewController *settingsViewController;
@property (strong, nonatomic) IBOutlet UIButton *buttonLoginLogout;
@property (strong, nonatomic) IBOutlet UITextView *textNoteOrLink;
@property (strong, nonatomic) IBOutlet FBProfilePictureView *userProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

- (IBAction)buttonClickHandler:(id)sender;
- (void)updateView;

@end
