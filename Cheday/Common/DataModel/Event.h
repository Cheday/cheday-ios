//
//  Event.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 31.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Parse/Parse.h>
#import "User.h"
#import "EventCategory.h"

@interface Event : PFObject
<PFSubclassing>

@property(nonatomic, strong) User *owner;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *endDate;
@property(nonatomic, strong) NSArray *volonteerRoles;
@property(nonatomic, strong) EventCategory *category;

@end
