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

@import CocoaLumberjack;
extern DDLogLevel ddLogLevel;

@interface VolonteerFormTableViewController ()
<VolonteerChooseTableViewControllerDelegate>

@property(nonatomic, weak) VolonteerChooseEventCategoriesTableViewController *chooseEventCategoriesVC;
@property(nonatomic, weak) VolonteerChooseEventCategoriesTableViewController *chooseDatesVC;
@property(nonatomic, weak) VolonteerChooseEventCategoriesTableViewController *chooseVolonteerRolesVC;

@end

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
        self.chooseEventCategoriesVC = segue.destinationViewController;
        self.chooseEventCategoriesVC.delegate = self;
        self.chooseEventCategoriesVC.selectedObjects = self.selectedPreferredEventCategories;
    }else if([segue.identifier isEqualToString:@"VolonteerFromShowChooseRoles"])
    {
        self.chooseVolonteerRolesVC = segue.destinationViewController;
        self.chooseVolonteerRolesVC.delegate = self;
        self.chooseVolonteerRolesVC.selectedObjects = self.selectedPreferredVolonteerRoles;
    } else if([segue.identifier isEqualToString:@"VolonteerFromShowChooseDates"])
    {
        self.chooseDatesVC = segue.destinationViewController;
        self.chooseDatesVC.delegate = self;
        self.chooseDatesVC.selectedObjects = self.selectedPreferredDates;
    }
}

-(void)chooseTableViewController:(VolonteerAbstractChooseTableViewController *)viewController didSelectObject:(id)object
{
    if(viewController == self.chooseEventCategoriesVC)
    {
        [self.selectedPreferredEventCategories addObject:object];
    }else if (viewController == self.chooseVolonteerRolesVC)
    {
        [self.selectedPreferredVolonteerRoles addObject:object];
    }else if (viewController == self.chooseDatesVC)
    {
        [self.selectedPreferredDates addObject:object];
    }else
    {
        NSAssert(NO, @"Unhandled delegate message sent from %@", viewController);
    }
}

-(void)chooseTableViewController:(VolonteerAbstractChooseTableViewController *)viewController didDeselectObject:(id)object
{
    if(viewController == self.chooseEventCategoriesVC)
    {
        [self.selectedPreferredEventCategories removeObject:object];
    }else if (viewController == self.chooseVolonteerRolesVC)
    {
        [self.selectedPreferredVolonteerRoles removeObject:object];
    }else if (viewController == self.chooseDatesVC)
    {
        [self.selectedPreferredDates removeObject:object];
    }else
    {
        NSAssert(NO, @"Unhandled delegate message sent from %@", viewController);
    }
}

@end
