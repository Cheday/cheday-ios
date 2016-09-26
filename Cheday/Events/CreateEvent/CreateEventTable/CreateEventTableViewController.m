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
#import "CreateEventDateTableViewCell.h"
#import "EventCategory.h"

#import "CreateEventChooseVolonteerRolesTableViewController.h"

#import <CocoaLumberjack/CocoaLumberjack.h>
extern DDLogLevel ddLogLevel;

@interface CreateEventTableViewController ()
<VolonteerChooseTableViewControllerDelegate, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet CreateEventTableViewCell *categoryCell;
@property(nonatomic, weak) CreateEventChooseCategoryTableViewController *chooseCategoryTVC;

@property (weak, nonatomic) IBOutlet CreateEventDateTableViewCell *startDateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *startDatePickerCell;
@property (nonatomic) BOOL editingStartDate;

@property (weak, nonatomic) IBOutlet CreateEventDateTableViewCell *endDateCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *endDatePickerCell;
@property (nonatomic) BOOL editingEndDate;

@property (weak, nonatomic) IBOutlet CreateEventTableViewCell *volonteersCell;
@property(nonatomic, weak) CreateEventChooseVolonteerRolesTableViewController *chooseVolonteerRolesTVC;

@end

@implementation CreateEventTableViewController

-(IBAction) eventNameTextDidChanged:(UITextField*)sender
{
    self.eventTitle = sender.text;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (IBAction)addImageButtonTouchUpInside:(UIButton *)sender {
}

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
        [self setVolonteerFilledStringForCell];
    }else{
        NSAssert(NO, @"Unhandled delegate message sent from %@", viewController);
    }
}

-(void)chooseTableViewController:(VolonteerAbstractChooseTableViewController *)viewController didDeselectObject:(id)object
{
    if(viewController == self.chooseVolonteerRolesTVC)
    {
        [self.selectedVolonteerRoles removeObject:object];
        [self setVolonteerFilledStringForCell];
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

-(void) setVolonteerFilledStringForCell
{
    if(self.selectedVolonteerRoles.count)
    {
        self.volonteersCell.filledString = [NSString stringWithFormat:@"%@ - %lu",NSLocalizedString(@"Волонтеры", nil), (unsigned long)self.selectedVolonteerRoles.count];
    }else
    {
        self.volonteersCell.filledString = nil;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 3) //Start date picker
    {
        if(self.editingStartDate)
            return 217;
        else
            return 0;
    }
    if(indexPath.row == 5) //End date picker
    {
        if(self.editingEndDate)
            return 217;
        else
            return 0;
    }
    return 44;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView beginUpdates];
    if(indexPath.row == 2) //Start date
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        self.editingStartDate = !self.editingStartDate;
        self.editingEndDate = NO;
    }else if(indexPath.row == 4) //End date
    {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        self.editingStartDate = NO;
        self.editingEndDate = !self.editingEndDate;
    }
    [tableView endUpdates];
}

- (IBAction)startDateValueChanged:(UIDatePicker *)sender {
    self.startDateCell.filledString = [NSDateFormatter localizedStringFromDate:sender.date
                                                                     dateStyle:NSDateFormatterMediumStyle
                                                                     timeStyle:NSDateFormatterShortStyle];
    self.startDate = sender.date;
}

- (IBAction)endDateValueChanged:(UIDatePicker *)sender {
    self.endDateCell.filledString = [NSDateFormatter localizedStringFromDate:sender.date
                                                                     dateStyle:NSDateFormatterMediumStyle
                                                                     timeStyle:NSDateFormatterShortStyle];
    self.endDate = sender.date;
}

@end
