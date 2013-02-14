//
//  INAppDelegate.m
//  IndiaSearch
//
//  Created by Manu Sharma on 1/15/13.
//  Copyright (c) 2013 Manu Sharma. All rights reserved.
//

#import "INAppDelegate.h"
#import "INFirstViewController.h"
#import "INSecondViewController.h"

@implementation INAppDelegate
@synthesize window = _window;
@synthesize session = _session;


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // attempt to extract a token from the url
    return [self.session handleOpenURL:url];
}



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [FBProfilePictureView class];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    UIViewController *viewController1, *viewController2;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        viewController1 = [[INFirstViewController alloc] initWithNibName:@"INFirstViewController_iPhone" bundle:nil];
        viewController2 = [[INSecondViewController alloc] initWithNibName:@"INSecondViewController_iPhone" bundle:nil];
    } else {
        viewController1 = [[INFirstViewController alloc] initWithNibName:@"INFirstViewController_iPad" bundle:nil];
        viewController2 = [[INSecondViewController alloc] initWithNibName:@"INSecondViewController_iPad" bundle:nil];
    }
    self.tabBarController = [[UITabBarController alloc] init];
    UINavigationController *navController1 = [[UINavigationController alloc] initWithRootViewController:viewController1];
    self.tabBarController.viewControllers = @[navController1, viewController2];
    UIImage *navImage = [UIImage imageNamed:@"navBar.png"];
    [navController1.navigationBar setBackgroundImage:navImage forBarMetrics:UIBarMetricsDefault];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
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


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
    NSLog(@"Application Resigning active State");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // Marking The session as logged in when user is returned from facebook.
    [FBSession.activeSession handleDidBecomeActive];
    

}

- (void)applicationWillTerminate:(UIApplication *)application
{
    //[self.session close];
    [FBSession.activeSession close];
}

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
