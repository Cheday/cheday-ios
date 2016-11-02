//
//  VolonteerEventViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 01.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerEventViewController.h"

@interface VolonteerEventViewController ()

@end

@implementation VolonteerEventViewController

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"VolonteerEventEmbedEvent"])
    {
        UIViewController<EventVCProtocol> *eventVC = segue.destinationViewController;
        eventVC.event = self.event;
    }
}
- (IBAction)wantToParticipateButtonTouchUpInside:(UIButton *)sender {
}

@end
