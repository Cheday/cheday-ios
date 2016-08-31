//
//  Event.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 31.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "Event.h"

@implementation Event

@dynamic owner, title, startDate, endDate, volonteerRoles, category;

+(NSString *)parseClassName
{
    return @"Event";
}

+(void)load
{
    [self registerSubclass];
}

@end
