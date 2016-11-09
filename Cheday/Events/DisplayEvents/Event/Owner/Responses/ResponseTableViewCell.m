//
//  ResponseTableViewCell.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 08.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "ResponseTableViewCell.h"
#import <AFNetworking/AFNetworking.h>

@interface ResponseTableViewCell ()

@property(nonatomic, weak) IBOutlet UIImageView *userImageView;
@property(nonatomic, weak) IBOutlet UILabel *userFullNameLabel;
@property(nonatomic, weak) IBOutlet UIButton *assignButton;

@end

@implementation ResponseTableViewCell

-(void)setEventParticipation:(EventParticipation *)eventParticipation
{
    [_eventParticipation removeObserver:self
                             forKeyPath:@"state"
                                context:(__bridge void * _Nullable)(self)];
    _eventParticipation = eventParticipation;
    [_eventParticipation addObserver:self
                          forKeyPath:@"state"
                             options:NSKeyValueObservingOptionInitial|NSKeyValueObservingOptionNew
                             context:(__bridge void * _Nullable)(self)];
    
    [self.userImageView setImageWithURL:[NSURL URLWithString:_eventParticipation.user.photoURLString]
                       placeholderImage:[UIImage imageNamed:@"ProfilePirate"]];
    self.userFullNameLabel.text = _eventParticipation.user.fullName;
}

-(void)dealloc
{
    self.eventParticipation = nil;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if((context == (__bridge void * _Nullable)(self)) && [_eventParticipation isEqual:object] && [keyPath isEqualToString:@"state"])
    {
        if([_eventParticipation.state isEqualToString:kEventParticipationStateSentToOwner])
        {
            [self.assignButton setTitle:NSLocalizedString(@"Назначить", nil)
                               forState:UIControlStateNormal];
            [self.assignButton setBackgroundImage:[UIImage imageNamed:@"button_normal_background"]
                                         forState:UIControlStateNormal];
        }else if([_eventParticipation.state isEqualToString:kEventParticipationStateAcceptedByOwner])
        {
            [self.assignButton setTitle:NSLocalizedString(@"Назначен", nil)
                               forState:UIControlStateNormal];
            [self.assignButton setBackgroundImage:[UIImage imageNamed:@"greenPixel"]
                                         forState:UIControlStateNormal];
        }
    }
}

-(IBAction)assignButtonTouchUpInside:(id)sender
{
    [self.delegate responseTableViewCellAssignButtonTap:self];
}

@end
