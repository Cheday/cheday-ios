//
//  WeekDayEqualityProxy.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 23.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "WeekDayEqualityProxy.h"

@implementation WeekDayEqualityProxy

-(instancetype)initWithWeekDay:(WeekDay *)weekDay
{
    _instance = weekDay;
    return self;
}

+(instancetype)proxyWithWeekDay:(WeekDay *)weekDay
{
    return [[self alloc] initWithWeekDay:weekDay];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_instance methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:_instance];
}

-(BOOL)isEqual:(id)object
{
    if(_instance == object)
        return YES;
    if(!object || ![object isKindOfClass:[_instance class]])
        return NO;
    return [self isEqualToWeekDay:object];
}

-(BOOL) isEqualToWeekDay:(WeekDay*)weekDay
{
    if(_instance == weekDay)
        return YES;
    if((_instance.objectId != weekDay.objectId) && ![_instance.objectId isEqualToString:weekDay.objectId])
        return NO;
    if((_instance.name != weekDay.name) && ![_instance.name isEqual:weekDay.name])
        return NO;
    return YES;
}

-(NSUInteger)hash
{
    return [_instance.objectId hash];
}

@end
