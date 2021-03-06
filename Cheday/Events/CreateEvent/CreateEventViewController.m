//
//  CreateEventViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 25.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventViewController.h"
#import "CreateEventTableViewController.h"
#import "Event.h"
#import "VolonteerRole+Counting.h"
#import "VolonteerRoleWithCount.h"
#import "UIAlertController+SimpleAlert.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
extern DDLogLevel ddLogLevel;
#import "ImageReducer.h"

@interface CreateEventViewController ()

@property(nonatomic, weak) CreateEventTableViewController *createEventTVC;
@property (weak, nonatomic) IBOutlet UIButton *createEventButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation CreateEventViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CreateEventEmbedCreateEventTableViewController"])
    {
        self.createEventTVC = segue.destinationViewController;
    }
}

- (IBAction)onCreateEventTouchUpInside:(UIButton *)sender
{
    NSAssert(!(self.createEventTVC.selectedCategories.count > 1), @"self.createEventTVC.selectedCategories.count>1");
    
    Event *event = [Event new];
    event.owner = [User currentUser];
    event.title = self.createEventTVC.eventTitle;
    if(self.createEventTVC.eventImage)
    {
        UIImage *resizedImage = nil;
        resizedImage = [[ImageReducer new] reduceImage:self.createEventTVC.eventImage
                                                toSize:CGSizeMake(2048, 2048)];
        event.image = [PFFile fileWithData:UIImageJPEGRepresentation(resizedImage,0.9)
                               contentType:@"image/jpeg"];
    }
    if(!event.title.length)
    {
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Событие должно иметь название", nil)
                                        fromViewController:self];
        return;
    }
    
    event.category = self.createEventTVC.selectedCategories.anyObject;
    if(event.category == nil)
    {
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Не выбрано ни одной категории", nil)
                                        fromViewController:self];
        return;
    }
    event.startDate = self.createEventTVC.startDate;
    if(event.startDate == nil)
    {
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Не выбрана дата начала", nil)
                                        fromViewController:self];
        return;
    }
    
    event.endDate = self.createEventTVC.endDate;
    if(event.endDate == nil)
    {
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Не выбрана дата окончания", nil)
                                        fromViewController:self];
        return;
    }
    
    NSMutableArray *array = [NSMutableArray new];
    [self.createEventTVC.selectedVolonteerRoles enumerateObjectsUsingBlock:^(VolonteerRole *  _Nonnull obj, BOOL * _Nonnull stop) {
        VolonteerRoleWithCount *volonteerRoleWithCount = [VolonteerRoleWithCount new];
        volonteerRoleWithCount.volonteerRole = obj;
        volonteerRoleWithCount.count = @(obj.count);
        [array addObject:volonteerRoleWithCount];
    }];
    event.volonteerRoles = array;
    
    event.details = self.createEventTVC.eventDetailsString;
    
    self.createEventButton.enabled = NO;
    [self.activityIndicator startAnimating];
    DDLogDebug(@"Save event: %@", event);
    [event saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        [self.activityIndicator stopAnimating];
        self.createEventButton.enabled = YES;
        if(succeeded)
        {
            DDLogDebug(@"Event saved");
            [self performSegueWithIdentifier:@"UnwindFromCreateEventViewController" sender:self];
        }else
        {
            [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                       message:error.localizedDescription
                                            fromViewController:self];
        }
    }];
}

@end
