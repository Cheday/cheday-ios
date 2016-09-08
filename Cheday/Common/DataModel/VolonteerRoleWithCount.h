//
//  VolonteerRoleWithCount.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 08.09.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Parse/Parse.h>
#import "VolonteerRole.h"

@interface VolonteerRoleWithCount : PFObject
<PFSubclassing>

@property(nonatomic, strong) VolonteerRole *volonteerRole;
@property(nonatomic, strong) NSNumber *count;

@end
