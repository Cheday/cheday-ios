//
//  VolonteerRoleWithCount.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 08.09.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerRoleWithCount.h"

@implementation VolonteerRoleWithCount

@dynamic volonteerRole, count;

+(NSString *)parseClassName
{
    return @"VolonteerRoleWithCount";
}

+(void)load
{
    [self registerSubclass];
}

@end
