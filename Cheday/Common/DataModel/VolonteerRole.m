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

@end
