//
//  EventCategoryEqualityProxy.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 23.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventCategoryEqualityProxy.h"

@implementation EventCategoryEqualityProxy

-(instancetype)initWithEventCategory:(EventCategory *)eventCategory
{
    _instance = eventCategory;
    return self;
}

+(instancetype)proxyWithEventCategory:(EventCategory *)eventCategory
{
    return [[self alloc] initWithEventCategory:eventCategory];
}

-(NSMethodSignature *)methodSignatureForSelector:(SEL)sel
{
    return [_instance methodSignatureForSelector:sel];
}

-(void)forwardInvocation:(NSInvocation *)invocation
{
    [invocation invokeWithTarget:_instance];
}

-(Class)class
{
    if(_instance)
        return [_instance class];
    return [EventCategoryEqualityProxy class];
}

-(Class)superclass
{
    if(_instance)
        return [_instance superclass];
    return [super class];
}

-(BOOL)isEqual:(id)object
{
    if(_instance == object)
        return YES;
    if(!object || ![object isKindOfClass:[_instance class]])
        return NO;
    return [self isEqualToEventCategory:object];
}

-(BOOL) isEqualToEventCategory:(EventCategory*)eventCategory
{
    if(_instance == eventCategory)
        return YES;
    if((_instance.objectId != eventCategory.objectId) && ![_instance.objectId isEqualToString:eventCategory.objectId])
        return NO;
    if((_instance.name != eventCategory.name) && ![_instance.name isEqual:eventCategory.name])
        return NO;
    return YES;
}

-(NSUInteger)hash
{
    return [_instance.objectId hash];
}

@end
