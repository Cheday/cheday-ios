//
//  VolonteerFormTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 10.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerFormTableViewController.h"
#import "VolonteerEventCategoriesTableViewController.h"
#import "VolonteerRolesChooseTableViewController.h"
//#import "VolonteerDates"
#import "User.h"

@interface VolonteerFormTableViewController ()

@property(nonatomic, strong) NSMutableSet *selectedEventCategories;
@property(nonatomic, strong) NSMutableSet *selectedPreferredVolonteerRoles;
@property(nonatomic, strong) NSMutableSet *selectedDates;

@end

@implementation VolonteerFormTableViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"VolonteerFromShowChooseCategories"])
    {
        if(self.selectedEventCategories == nil)
        {
            self.selectedEventCategories = [NSMutableSet setWithArray:[User currentUser].preferredEventCategories];
        }
        VolonteerEventCategoriesTableViewController *vc = segue.destinationViewController;
        vc.selectedObjects = self.selectedEventCategories;
        
    }else if([segue.identifier isEqualToString:@"VolonteerFromShowChooseRoles"])
    {
        if(self.selectedPreferredVolonteerRoles == nil)
        {
            self.selectedPreferredVolonteerRoles = [NSMutableSet setWithArray:[User currentUser].preferredVolonteerRoles];
        }
        VolonteerRolesChooseTableViewController *vc = segue.destinationViewController;
        vc.selectedObjects = self.selectedPreferredVolonteerRoles;
    } else if([segue.identifier isEqualToString:@"VolonteerFromShowChooseDates"])
    {
        
    }
}

@end
