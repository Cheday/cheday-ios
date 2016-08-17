//
//  EventCategory+Selected.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 17.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventCategory+Selected.h"
#import <objc/runtime.h>

@implementation EventCategory (Selected)

-(BOOL)selected
{
    return [objc_getAssociatedObject(self, "selected") boolValue];
}

-(void)setSelected:(BOOL)selected
{
    objc_setAssociatedObject(self, "selected", @(selected), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
