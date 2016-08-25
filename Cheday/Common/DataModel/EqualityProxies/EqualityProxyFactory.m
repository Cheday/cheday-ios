//
//  EqualityProxyFactory.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 24.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EqualityProxyFactory.h"

#import "EventCategoryEqualityProxy.h"
#import "VolonteerRoleEqualityProxy.h"
#import "WeekDayEqualityProxy.h"

@implementation EqualityProxyFactory

-(id)proxyForObject:(id)object
{
    if([object isKindOfClass:[EventCategory class]])
        return [EventCategoryEqualityProxy proxyWithEventCategory:object];
    
    if([object isKindOfClass:[VolonteerRole class]])
        return [VolonteerRoleEqualityProxy proxyWithVolonteerRole:object];
    
    if([object isKindOfClass:[WeekDay class]])
        return [WeekDayEqualityProxy proxyWithWeekDay:object];
    
    return nil;
}

-(NSArray *)proxyArrayForObjectsArray:(NSArray *)array
{
    NSMutableArray *newArray = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [newArray addObject:[self proxyForObject:obj]];
    }];
    return newArray;
}

@end
