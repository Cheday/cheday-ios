//
//  CreateEventViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 25.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventViewController.h"
#import "CreateEventTableViewController.h"

@interface CreateEventViewController ()

@property(nonatomic, weak) CreateEventTableViewController *createEventTVC;

@end

@implementation CreateEventViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"CreateEventEmbedCreateEventTableViewController"])
    {
        self.createEventTVC = segue.destinationViewController;
    }
}

- (IBAction)onCreateEventTouchUpInside:(UIButton *)sender {
    
}

@end
