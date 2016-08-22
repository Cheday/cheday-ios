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
    if([super isEqual:object])
    {
        return YES;
    }
    return [self isEqualToEventCategory:object];
}

-(BOOL) isEqualToEventCategory:(EventCategory*)eventCategory
{
    return [self.objectId isEqualToString:eventCategory.objectId]||[self.name isEqual:eventCategory.name];
}

-(NSUInteger)hash
{
    return [self.name hash];
}

@end
