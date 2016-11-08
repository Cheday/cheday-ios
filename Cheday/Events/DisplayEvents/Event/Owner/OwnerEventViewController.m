//
//  OwnerEventViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 01.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "OwnerEventViewController.h"

@interface OwnerEventViewController ()

@end

@implementation OwnerEventViewController

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"OwnerEventEmbedEvent"]||
       [segue.identifier isEqualToString:@"OwnerEventShowResponses"])
    {
        UIViewController<EventVCProtocol> *eventVC = segue.destinationViewController;
        eventVC.event = self.event;
    }
}


@end
