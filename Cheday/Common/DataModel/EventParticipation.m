//
//  EventParticipation.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 02.11.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "EventParticipation.h"

NSString* const kEventParticipationStateSentToVolonteer = @"SentToVolonteer";
NSString* const kEventParticipationStateDeclinedByVolonteer = @"DeclinedByVolonteer";
NSString* const kEventParticipationStateSentToOwner = @"SentToOwner";
NSString* const kEventParticipationStateAcceptedByOwner = @"AcceptedByOwner";
NSString* const kEventParticipationStateDeclinedByOwner = @"DeclinedByOwner";
NSString* const kEventParticipationStateCancelled = @"Cancelled";

@implementation EventParticipation

@dynamic event, user, volonteerRole, state;

+(NSString *)parseClassName
{
    return @"EventParticipation";
}

+(void)load
{
    [self registerSubclass];
}
@end
