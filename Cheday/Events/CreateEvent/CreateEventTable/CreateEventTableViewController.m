//
//  CreateEventTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 29.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventTableViewController.h"
#import "CreateEventChooseCategoryTableViewController.h"
#import "CreateEventTableViewCell.h"
#import "EventCategory.h"

#import "CreateEventChooseVolonteerRolesTableViewController.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
extern DDLogLevel ddLogLevel;

@interface CreateEventTableViewController ()
<VolonteerChooseTableViewControllerDelegate>

@property(nonatomic, weak) CreateEventChooseCategoryTableViewController *chooseCategoryTVC;
@property(nonatomic, weak) CreateEventChooseVolonteerRolesTableViewController *chooseVolonteerRolesTVC;

@property (weak, nonatomic) IBOutlet CreateEventTableViewCell *categoryCell;

@end

@implementation CreateEventTableViewController

#pragma mark - Navigation

-(NSMutableSet *)selectedCategories
{
    if(_selectedCategories == nil)
    {
        _selectedCategories = [NSMutableSet new];
    }
    return _selectedCategories;
}

-(NSMutableSet *)selectedVolonteerRoles
{
    if(_selectedVolonteerRoles == nil)
    {
        _selectedVolonteerRoles = [NSMutableSet new];
    }
    return _selectedVolonteerRoles;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"CreateEventShowChooseCategory"])
    {
        CreateEventChooseCategoryTableViewController *chooseCategoryVC = segue.destinationViewController;
        chooseCategoryVC.selectedObjects = self.selectedCategories;
        chooseCategoryVC.delegate = self;
        self.chooseCategoryTVC = chooseCategoryVC;
    }else if([segue.identifier isEqualToString:@"CreateEventShowChooseVolonteerRoles"])
    {
        CreateEventChooseVolonteerRolesTableViewController *chooseRolesTVC = segue.destinationViewController;
        chooseRolesTVC.selectedObjects = self.selectedVolonteerRoles;
        chooseRolesTVC.delegate = self;
        self.chooseVolonteerRolesTVC = chooseRolesTVC;
    }
}

-(void)chooseTableViewController:(VolonteerAbstractChooseTableViewController *)viewController didSelectObject:(id)object
{
    if(viewController == self.chooseCategoryTVC)
    {
        [self.selectedCategories removeAllObjects];
        [self.selectedCategories addObject:object];
    }else if(viewController == self.chooseVolonteerRolesTVC)
    {
        [self.selectedVolonteerRoles addObject:object];
    }else{
        NSAssert(NO, @"Unhandled delegate message sent from %@", viewController);
    }
}

-(void)chooseTableViewController:(VolonteerAbstractChooseTableViewController *)viewController didDeselectObject:(id)object
{
    if(viewController == self.chooseVolonteerRolesTVC)
    {
        [self.selectedVolonteerRoles removeObject:object];
    }else
    {
        NSAssert(NO, @"Unhandled delegate message sent from %@", viewController);
    }
}

-(IBAction)unwindFromCreateEventChooseCategoryTableViewController:(UIStoryboardSegue*)segue
{
    EventCategory *eventCategory = self.selectedCategories.anyObject;
    self.categoryCell.filledString = eventCategory.name;
}

@end