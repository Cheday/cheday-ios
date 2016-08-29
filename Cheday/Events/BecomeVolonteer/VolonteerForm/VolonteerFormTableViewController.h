//
//  VolonteerFormTableViewController.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 10.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VolonteerFormTableViewController : UITableViewController

@property(nonatomic, strong) NSMutableSet *selectedPreferredEventCategories;
@property(nonatomic, strong) NSMutableSet *selectedPreferredVolonteerRoles;
@property(nonatomic, strong) NSMutableSet *selectedPreferredDates;

@end
