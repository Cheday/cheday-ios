//
//  ProfileUpdaterFromTwitter.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 04.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "ProfileUpdaterFromTwitter.h"
@import AFNetworking;
@import ParseTwitterUtils;
@import CocoaLumberjack;
extern DDLogLevel ddLogLevel;

@implementation ProfileUpdaterFromTwitter

+(void) updateUser:(User*)user completion:(void (^)(User* user, NSError* error))completionBlock
{
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://api.twitter.com/1.1/account/verify_credentials.json"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:URL];
    [[PFTwitterUtils twitter] signRequest:request];
    DDLogDebug(@"ProfileUpdaterFromTwitter: get twitter profile");
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request completionHandler:^(NSURLResponse *response, id responseObject, NSError *error) {
        if (error) {
            DDLogError(@"ProfileUpdaterFromTwitter Error: %@", error);
        } else {
            DDLogDebug(@"ProfileUpdaterFromTwitter: get twitter profile OK");
            DDLogVerbose(@"ProfileUpdaterFromTwitter: %@ %@", response, responseObject);
            
            user.twitterID = responseObject[@"id_str"];
            user.twitterPhotoURLString = [responseObject[@"profile_image_url_https"] stringByReplacingOccurrencesOfString:@"_normal"
                                                                                                               withString:@"_bigger"];
            user.twitterName = responseObject[@"name"];
        }
        completionBlock(user, error);
    }];
    [dataTask resume];
}

@end
