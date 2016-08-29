//
//  CreateEventTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 29.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventTableViewController.h"
#import "CreateEventChooseCategoryTableViewController.h"

@interface CreateEventTableViewController ()

@end

@implementation CreateEventTableViewController

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

-(IBAction)unwindFromCreateEventChooseCategoryTableViewController:(UIStoryboardSegue*)segue
{
    CreateEventChooseCategoryTableViewController *vc = segue.sourceViewController;
    self.selectedCategories = vc.selectedObjects;
}

@end
