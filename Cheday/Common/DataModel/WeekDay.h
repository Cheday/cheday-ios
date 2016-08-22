//
//  WeekDay.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Parse/Parse.h>

@interface WeekDay : PFObject
<PFSubclassing>

@property(nonatomic, strong) NSString *name;

@end
