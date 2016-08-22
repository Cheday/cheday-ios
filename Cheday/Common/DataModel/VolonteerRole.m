//
//  VolonteerRole.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 19.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerRole.h"

@implementation VolonteerRole

@dynamic name;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"VolonteerRole";
}

-(BOOL)isEqual:(id)object
{
    if(self == object)
        return YES;
    if(!object || ![object isKindOfClass:[self class]])
        return NO;
    return [self isEqualToEventCategory:object];
}

-(BOOL) isEqualToEventCategory:(VolonteerRole*)volonteerRole
{
    if(self == volonteerRole)
        return YES;
    if((self.objectId != self.objectId) && ![self.objectId isEqualToString:volonteerRole.objectId])
        return NO;
    if((self.name != volonteerRole.name) && ![self.name isEqual:volonteerRole.name])
        return NO;
    return YES;
}

-(NSUInteger)hash
{
    return [self.objectId hash];
}

@end
