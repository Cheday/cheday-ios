//
//  CreateEventTableViewController.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 29.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateEventTableViewController : UITableViewController

@property(nonatomic, strong) NSString *eventTitle;
@property(nonatomic, strong) NSMutableSet *selectedCategories;
@property(nonatomic, strong) NSDate *startDate;
@property(nonatomic, strong) NSDate *endDate;
@property(nonatomic, strong) NSMutableSet *selectedVolonteerRoles;

@end
