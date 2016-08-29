//
//  VolonteerRole+Selecting.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 19.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerRole+Selecting.h"
#import <objc/runtime.h>

@implementation VolonteerRole (Selecting)

-(BOOL)selected
{
    return [objc_getAssociatedObject(self, "selected") boolValue];
}

-(void)setSelected:(BOOL)selected
{
    objc_setAssociatedObject(self, "selected", @(selected), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
