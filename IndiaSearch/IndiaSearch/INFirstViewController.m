//
//  INFirstViewController.m
//  IndiaSearch
//
//  Created by Manu Sharma on 1/15/13.
//  Copyright (c) 2013 Manu Sharma. All rights reserved.
//

#import "INFirstViewController.h"
#import "INAppDelegate.h"
#import <FacebookSDK/FacebookSDK.h>

@interface INFirstViewController ()

@end

@implementation INFirstViewController

@synthesize textNoteOrLink = _textNoteOrLink;
@synthesize buttonLoginLogout = _buttonLoginLogout;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                self.title = @"Welcome!";
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
      
    return self;
}
							
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    }

-(void) viewWillAppear:(BOOL)animated{
    [self updateView];
    
    INAppDelegate *appDelegate = (INAppDelegate*)[[UIApplication sharedApplication] delegate];
    //if (FBSession.activeSession.isOpen) {
        //NSLog(@"View will appear: sesion open");
        
        [self populateUserDetails];
    //}

    if (!appDelegate.session.isOpen) {
        // create a fresh session object
        appDelegate.session = [[FBSession alloc] init];
        
        // if we don't have a cached token, a call to open here would cause UX for login to
        // occur; we don't want that to happen unless the user clicks the login button, and so
        // we check here to make sure we have a token before calling open
        if (appDelegate.session.state == FBSessionStateCreatedTokenLoaded) {
            // even though we had a cached token, we need to login to make the session usable
            [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                             FBSessionState status,
                                                             NSError *error) {
                // we recurse here, in order to update buttons and labels
                [self updateView];
            }];
        }
    }

}


#pragma mark Template generated code

- (void)viewDidUnload
{
    self.buttonLoginLogout = nil;
    self.textNoteOrLink = nil;
    
    [self setUserNameLabel:nil];
    [super viewDidUnload];
}



#pragma ButtonClick
// handler for button click, logs sessions in or out
- (IBAction)buttonClickHandler:(id)sender {
    // get the app delegate so that we can access the session property
    INAppDelegate *appDelegate = (INAppDelegate*)[[UIApplication sharedApplication]delegate];
    
    // this button's job is to flip-flop the session from open to closed
    if (appDelegate.session.isOpen) {
        // if a user logs out explicitly, we delete any cached token information, and next
        // time they run the applicaiton they will be presented with log in UX again; most
        // users will simply close the app or switch away, without logging out; this will
        // cause the implicit cached-token login to occur on next launch of the application
        [appDelegate.session closeAndClearTokenInformation];
        
    } else {
        if (appDelegate.session.state != FBSessionStateCreated) {
            // Create a new, logged out session.
            appDelegate.session = [[FBSession alloc] init];
        }
        
        // if the session isn't open, let's open it now and present the login UX to the user
        [appDelegate.session openWithCompletionHandler:^(FBSession *session,
                                                         FBSessionState status,
                                                         NSError *error) {
            // and here we make sure to update our UX according to the new session state
            [self updateView];
        }];
    }
}


-(void)updateView{
    // get the app delegate, so that we can reference the session property
    INAppDelegate *appDelegate = (INAppDelegate*)[[UIApplication sharedApplication]delegate];
    if (appDelegate.session.isOpen) {
        // valid account UI is shown whenever the session is open
        NSLog(@"Session Open");
        [self.buttonLoginLogout setTitle:@"Log out" forState:UIControlStateNormal];
        [self.textNoteOrLink setText:[NSString stringWithFormat:@"https://graph.facebook.com/me/friends?access_token=%@",
                                      appDelegate.session.accessToken]];
        
    } else {
        // login-needed account UI is shown whenever the session is closed
        NSLog(@"Session Closed");
        [self.buttonLoginLogout setTitle:@"Log in" forState:UIControlStateNormal];
        [self.textNoteOrLink setText:@"Login to create a link to fetch account data"];
    }

    
}
- (void)populateUserDetails {
    INAppDelegate *appDelegate = (INAppDelegate*)[[UIApplication sharedApplication] delegate];
    [[FBRequest requestForMe] startWithCompletionHandler:
     ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
         NSLog(@"%@", user.first_name);
         if (!error) {
             self.userNameLabel.text = user.name;
             self.userProfileImage.profileID = [user objectForKey:@"id"];
         }
     }];
 
    if (appDelegate.session.isOpen) {
                [[FBRequest requestForMe] startWithCompletionHandler:
         ^(FBRequestConnection *connection, NSDictionary<FBGraphUser> *user, NSError *error) {
             NSLog(@"%@", user.first_name);
             if (!error) {
                 self.userNameLabel.text = user.name;
                 self.userProfileImage.profileID = [user objectForKey:@"id"];
             }
         }];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskAll;

}



@end
