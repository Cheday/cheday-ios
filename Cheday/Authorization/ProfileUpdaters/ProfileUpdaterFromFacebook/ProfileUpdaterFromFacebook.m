//
//  ProfileUpdaterFromFacebook.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 05.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "ProfileUpdaterFromFacebook.h"
@import FBSDKCoreKit;
@import CocoaLumberjack;
extern DDLogLevel ddLogLevel;

@implementation ProfileUpdaterFromFacebook

+(void) updateUser:(User*)user completion:(void (^)(User* user, NSError* error))completionBlock
{
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc] initWithGraphPath:@"me?fields=id,name,email"
                                                                   parameters:nil];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            DDLogDebug(@"ProfileUpdaterFromFacebook: get facebook profile OK");
            DDLogVerbose(@"ProfileUpdaterFromFacebook: %@", result);
            user.facebookID = result[@"id"];
            user.facebookName = result[@"name"];
            user.facebookPhotoURLString = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?return_ssl_resources=1", user.facebookID];
        }else
        {
            DDLogError(@"ProfileUpdaterFromFacebook Error: %@", error);
        }
        completionBlock(user, error);
    }];
}

@end
