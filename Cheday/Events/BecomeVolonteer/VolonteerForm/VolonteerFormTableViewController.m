//
//  VolonteerFormTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 10.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerFormTableViewController.h"
#import "VolonteerChooseEventCategoriesTableViewController.h"
#import "VolonteerChooseRolesTableViewController.h"
#import "VolonteerChooseDatesTableViewController.h"
#import "User.h"

@implementation VolonteerFormTableViewController

-(NSMutableSet *)selectedPreferredEventCategories
{
    if(_selectedPreferredEventCategories == nil)
    {
        self.selectedPreferredEventCategories = [NSMutableSet setWithArray:[User currentUser].preferredEventCategories];
    }
    return _selectedPreferredEventCategories;
}

-(NSMutableSet *)selectedPreferredVolonteerRoles
{
    if(_selectedPreferredVolonteerRoles == nil)
    {
        self.selectedPreferredVolonteerRoles = [NSMutableSet setWithArray:[User currentUser].preferredVolonteerRoles];
    }
    return _selectedPreferredVolonteerRoles;
}

-(NSMutableSet *)selectedPreferredDates
{
    if(_selectedPreferredDates == nil)
    {
        self.selectedPreferredDates = [NSMutableSet setWithArray:[User currentUser].preferredVolonteerDays];
    }
    return _selectedPreferredDates;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"VolonteerFromShowChooseCategories"])
    {
        VolonteerChooseEventCategoriesTableViewController *vc = segue.destinationViewController;
        vc.selectedObjects = self.selectedPreferredEventCategories;
    }else if([segue.identifier isEqualToString:@"VolonteerFromShowChooseRoles"])
    {
        VolonteerChooseRolesTableViewController *vc = segue.destinationViewController;
        vc.selectedObjects = self.selectedPreferredVolonteerRoles;
    } else if([segue.identifier isEqualToString:@"VolonteerFromShowChooseDates"])
    {
        VolonteerChooseDatesTableViewController *vc = segue.destinationViewController;
        vc.selectedObjects = self.selectedPreferredDates;
    }
}

@end
