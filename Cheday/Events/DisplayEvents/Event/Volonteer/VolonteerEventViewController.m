//
//  VolonteerEventViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 01.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerEventViewController.h"
#import "EventParticipation.h"
#import "SimpleAlertController.h"

@interface VolonteerEventViewController ()

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *wantToParticipateButtonActivityIndicator;

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
    EventParticipation *eventParticipation = [EventParticipation new];
    eventParticipation.user = [User currentUser];
    eventParticipation.event = self.event;
    eventParticipation.state = kEventParticipationStateSentToOwner;
    
    sender.enabled = NO;
    [self.wantToParticipateButtonActivityIndicator startAnimating];
    __weak typeof(self) weakSelf = self;
    [eventParticipation saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        sender.enabled = YES;
        [weakSelf.wantToParticipateButtonActivityIndicator stopAnimating];
        SimpleAlertController *alertVC;
        alertVC = [SimpleAlertController alertControllerWithTitle:NSLocalizedString(@"Уведомление", nil)
                                                          message:NSLocalizedString(@"Ваш запрос отправлен организатору", nil)];
        [weakSelf presentViewController:alertVC
                               animated:YES
                             completion:nil];
    }];
}

@end
