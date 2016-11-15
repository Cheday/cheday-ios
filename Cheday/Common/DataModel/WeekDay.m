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
    if(self == object)
        return YES;
    if(!object || ![object isKindOfClass:[WeekDay class]])
        return NO;
    return [self isEqualToWeekDay:object];
}

-(BOOL) isEqualToWeekDay:(WeekDay*)weekDay
{
    if(self == weekDay)
        return YES;
    if((self.objectId != weekDay.objectId) && ![self.objectId isEqualToString:weekDay.objectId])
        return NO;
    if((self.name != weekDay.name) && ![self.name isEqual:weekDay.name])
        return NO;
    return YES;
}

-(NSUInteger)hash
{
    return [self.objectId hash];
}

@end
