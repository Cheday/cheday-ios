//
//  EventParticipation.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 02.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <Parse/Parse.h>
#import "Event.h"
#import "VolonteerRole.h"

FOUNDATION_EXPORT NSString* const kEventParticipationStateSentToVolonteer;
FOUNDATION_EXPORT NSString* const kEventParticipationStateDeclinedByVolonteer;
FOUNDATION_EXPORT NSString* const kEventParticipationStateSentToOwner;
FOUNDATION_EXPORT NSString* const kEventParticipationStateAcceptedByOwner;
FOUNDATION_EXPORT NSString* const kEventParticipationStateDeclinedByOwner;
FOUNDATION_EXPORT NSString* const kEventParticipationStateCancelled;

@interface EventParticipation : PFObject
<PFSubclassing>

@property(nonatomic, strong) Event *event;
@property(nonatomic, strong) User *user;
@property(nonatomic, strong) VolonteerRole *volonteerRole;

/**
 State can be one of the following:

 @b kEventParticipationStateSentToVolonteer

 @b kEventParticipationStateDeclinedByVolonteer - not used now

 @b kEventParticipationStateSentToOwner

 @b kEventParticipationStateAcceptedByOwner

 @b kEventParticipationStateDeclinedByOwner

 @b kEventParticipationStateCancelled - not used now

 */
@property(nonatomic, strong) NSString *state;

@end
