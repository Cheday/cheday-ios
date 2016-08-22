//
//  VolonteerRole.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 19.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerRole.h"

@implementation VolonteerRole

@dynamic name;

+(void)load
{
    [self registerSubclass];
}

+(NSString *)parseClassName
{
    return @"VolonteerRole";
}

-(BOOL)isEqual:(id)object
{
    if([super isEqual:object])
    {
        return YES;
    }
    return [self isEqualToVolonteerRole:object];
}

-(BOOL) isEqualToVolonteerRole:(VolonteerRole*)volonteerRole
{
    return [self.objectId isEqualToString:volonteerRole.objectId]||[self.name isEqual:volonteerRole.name];
}

-(NSUInteger)hash
{
    return [self.name hash];
}

@end
