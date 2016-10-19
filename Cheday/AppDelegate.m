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
#ifdef DEBUG
    DDLogLevel ddLogLevel = DDLogLevelDebug;
#else 
    DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#ifndef DEBUG
    @import Fabric;
    @import Crashlytics;
#endif

@import ParseTwitterUtils;
@import ParseFacebookUtilsV4;
@import FBSDKCoreKit;

#import "LoginViewController.h"
#import "User.h"
#import "MainViewController.h"




@interface AppDelegate ()
<LoginViewControllerDelegate>

@property(nonatomic, strong) MainViewController *mainVC;

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
    
    [PFTwitterUtils initializeWithConsumerKey:@"peDNKySK2KhzdCzQwQp2K02i5"
                               consumerSecret:@"fYyaYYNclV4SZzmsT9T86eh9FcpbU8mNc8fp6QiIpsPpetjFA6"];
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
    
    UINavigationController *navController = (UINavigationController*)self.window.rootViewController;
    self.mainVC = (MainViewController*)navController.viewControllers[0];
//  self.mainVC = (MainViewController*)self.window.rootViewController;
    
    if([User currentUser] == nil)
    {
        [self performSelector:@selector(presentAuthorization) withObject:nil afterDelay:0];
    }else
    {
        self.mainVC.user = [User currentUser];
    }
    return YES;
}

- (void)presentAuthorization
{
    LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Authorization" bundle:nil] instantiateInitialViewController];
    loginVC.delegate = self;
    [self.window.rootViewController presentViewController:loginVC  animated:NO completion:nil];
}

-(void)loginViewControllerDidLogin:(LoginViewController *)loginViewController
{
    [self.window.rootViewController dismissViewControllerAnimated:YES completion:nil];
    self.mainVC.user = [User currentUser];
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
    [FBSDKAppEvents activateApp];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
    return [[FBSDKApplicationDelegate sharedInstance] application:app
                                                          openURL:url
                                                sourceApplication:options[UIApplicationLaunchOptionsSourceApplicationKey]
                                                       annotation:options[UIApplicationLaunchOptionsAnnotationKey]];
}

@end
