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

@interface VolonteerFormTableViewController ()

@property(nonatomic, strong) NSMutableSet *selectedPreferredEventCategories;
@property(nonatomic, strong) NSMutableSet *selectedPreferredVolonteerRoles;
@property(nonatomic, strong) NSMutableSet *selectedPreferredDates;

@end

@implementation VolonteerFormTableViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"VolonteerFromShowChooseCategories"])
    {
        if(self.selectedPreferredEventCategories == nil)
        {
            self.selectedPreferredEventCategories = [NSMutableSet setWithArray:[User currentUser].preferredEventCategories];
        }
        VolonteerChooseEventCategoriesTableViewController *vc = segue.destinationViewController;
        vc.selectedObjects = self.selectedPreferredEventCategories;
        
    }else if([segue.identifier isEqualToString:@"VolonteerFromShowChooseRoles"])
    {
        if(self.selectedPreferredVolonteerRoles == nil)
        {
            self.selectedPreferredVolonteerRoles = [NSMutableSet setWithArray:[User currentUser].preferredVolonteerRoles];
        }
        VolonteerChooseRolesTableViewController *vc = segue.destinationViewController;
        vc.selectedObjects = self.selectedPreferredVolonteerRoles;
    } else if([segue.identifier isEqualToString:@"VolonteerFromShowChooseDates"])
    {
        if(self.selectedPreferredDates == nil)
        {
            self.selectedPreferredDates = [NSMutableSet setWithArray:[User currentUser].preferredVolonteerDays];
        }
        VolonteerChooseDatesTableViewController *vc = segue.destinationViewController;
        vc.selectedObjects = self.selectedPreferredDates;
    }
}

@end
