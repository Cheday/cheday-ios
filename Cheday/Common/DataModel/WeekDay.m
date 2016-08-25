//
//  WeekDay.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "WeekDay.h"

@implementation WeekDay

@dynamic name;

+(NSString *)parseClassName
{
    return @"WeekDay";
}

+(void)load
{
    [self registerSubclass];
}

@end
