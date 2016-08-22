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

-(BOOL)isEqual:(id)object
{
    if([super isEqual:object])
    {
        return YES;
    }
    return [self isEqualToWeekDay:object];
}

-(BOOL) isEqualToWeekDay:(WeekDay*)weekDay
{
    return [self.objectId isEqualToString:weekDay.objectId]||[self.name isEqual:weekDay.name];
}

-(NSUInteger)hash
{
    return [self.name hash];
}


@end
