//
//  VolonteerRoleEqualityProxy.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 23.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerRoleEqualityProxy.h"

@implementation VolonteerRoleEqualityProxy

-(instancetype)initWithVolonteerRole:(VolonteerRole *)volonteerRole
{
    _instance = volonteerRole;
    return self;
}

+(instancetype)proxyWithVolonteerRole:(VolonteerRole *)volonteerRole
{
    return [[self alloc] initWithVolonteerRole:volonteerRole];
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
    return [VolonteerRoleEqualityProxy class];
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
    return [self isEqualToVolonteerRole:object];
}

-(BOOL) isEqualToVolonteerRole:(VolonteerRole*)volonteerRole
{
    if(_instance == volonteerRole)
        return YES;
    if((_instance.objectId != volonteerRole.objectId) && ![_instance.objectId isEqualToString:volonteerRole.objectId])
        return NO;
    if((_instance.name != volonteerRole.name) && ![_instance.name isEqual:volonteerRole.name])
        return NO;
    return YES;
}

-(NSUInteger)hash
{
    return [_instance.objectId hash];
}

@end
