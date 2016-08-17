//
//  EventCategory.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 15.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventCategory.h"
@import Parse.PFObject_Subclass;

@interface EventCategory ()
<PFSubclassing>

@end

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

@end
