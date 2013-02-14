//
//  INAppDelegate.h
//  IndiaSearch
//
//  Created by Manu Sharma on 1/15/13.
//  Copyright (c) 2013 Manu Sharma. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface INAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) FBSession *session;
@end
