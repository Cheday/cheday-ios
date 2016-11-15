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
@dynamic facebookID, facebookName, facebookPhotoURLString;
@dynamic wantToVolonteer, preferredEventCategories, preferredVolonteerRoles, preferredVolonteerDays;

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
        }else if(self.lastName.length)
        {
            fullName = self.lastName;
        }else if(self.facebookName.length)
        {
            fullName = self.facebookName;
        }else if(self.twitterName.length)
        {
            fullName = self.twitterName;
        }
    }
    return fullName;
}

-(NSString *)photoURLString
{
    NSString *photoURLString = nil;
    if(self.facebookPhotoURLString.length)
    {
        photoURLString = [self.facebookPhotoURLString stringByAppendingString:@"&width=200&height=200"];
    }else if(self.twitterPhotoURLString.length)
    {
        photoURLString = self.twitterPhotoURLString;
    }
    return photoURLString;
}

-(BOOL)isEqual:(id)object
{
    if(self == object)
        return YES;
    if(!object || ![object isKindOfClass:[User class]])
        return NO;
    return [self isEqualToUser:object];
}

-(BOOL) isEqualToUser:(User*)user
{
    if(self == user)
        return YES;
    if((self.objectId != user.objectId) && ![self.objectId isEqualToString:user.objectId])
        return NO;
//    if((self.name != user.name) && ![_instance.name isEqual:eventCategory.name])
//        return NO;
    return YES;
}

@end
