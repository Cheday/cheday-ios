//
//  EventCategory.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 15.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Parse/Parse.h>

@interface EventCategory : PFObject
<PFSubclassing>

@property(nonatomic, strong) NSString *name;

@end