//
//  AppDelegate.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 20.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "AppDelegate.h"
@import Parse;
@import IQKeyboardManager;
@import CocoaLumberjack;
DDLogLevel ddLogLevel = DDLogLevelAll;

#ifndef DEBUG
    @import Fabric;
    @import Crashlytics;
#endif

#import "LoginViewController.h"

@interface AppDelegate ()
<LoginViewControllerDelegate>

@end


@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];

#ifndef DEBUG
    [Fabric with:@[[Crashlytics class]]];
#endif
    
#ifdef DEBUG
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"ChedayApp";
        configuration.server = @"https://cheday.herokuapp.com/parse";
    }]];
#else
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration> configuration) {
        configuration.applicationId = @"ChedayApp";
        configuration.server = @"https://cheday.herokuapp.com/parse";
    }]];
#endif
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    [self performSelector:@selector(presentAuthorization) withObject:nil afterDelay:0];
    return YES;
}

- (void)presentAuthorization
{
    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"AuthorizationStoryboard" bundle:nil] instantiateInitialViewController];
    loginVC.delegate = self;
    [self.window.rootViewController presentViewController:loginVC  animated:YES completion:nil];
}

-(void)loginViewControllerDidLogin:(LoginViewController *)loginViewController
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
