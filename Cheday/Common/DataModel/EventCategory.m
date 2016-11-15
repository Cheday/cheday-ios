//
//  EventCategory.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 15.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventCategory.h"

@implementation EventCategory

@dynamic name;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"EventCategory";
}

-(BOOL)isEqual:(id)object
{
    if(self == object)
        return YES;
    if(!object || ![object isKindOfClass:[EventCategory class]])
        return NO;
    return [self isEqualToEventCategory:object];
}

-(BOOL) isEqualToEventCategory:(EventCategory*)eventCategory
{
    if(self == eventCategory)
        return YES;
    if((self.objectId != eventCategory.objectId) && ![self.objectId isEqualToString:eventCategory.objectId])
        return NO;
    //TODO: Add check for [self isDataAvailable:]
    if((self.name != eventCategory.name) && ![self.name isEqual:eventCategory.name])
        return NO;
    return YES;
}

-(NSUInteger)hash
{
    return [self.objectId hash];
}

@end
