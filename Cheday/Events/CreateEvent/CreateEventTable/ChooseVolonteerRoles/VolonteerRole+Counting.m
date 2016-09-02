//
//  VolonteerRole+Counting.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 02.09.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerRole+Counting.h"
#import <objc/runtime.h>

@implementation VolonteerRole (Counting)

-(NSInteger)count
{
    return [objc_getAssociatedObject(self, "count") integerValue];
}

-(void)setCount:(NSInteger)count
{
    objc_setAssociatedObject(self, "count", @(count), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
