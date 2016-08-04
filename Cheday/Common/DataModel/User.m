//
//  User.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 26.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "User.h"

@implementation User

@dynamic firstName, lastName;
@dynamic twitterID, twitterName, twitterPhotoURLString;
@dynamic facebookID;

+(void)load
{
    [self registerSubclass];
}

-(NSString *)fullName
{
    NSString *fullName = nil;
    if(self.firstName.length && self.lastName.length)
    {
        fullName = [[NSString alloc] initWithFormat:@"%@ %@", self.firstName, self.lastName];
    }else
    {
        if(self.firstName.length)
        {
            fullName = self.firstName;
        }else
        {
            fullName = self.lastName;
        }
    }
    return fullName;
}

@end
