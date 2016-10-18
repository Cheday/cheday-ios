//
//  NearEventsViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 18.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "NearEventsViewController.h"
#import "EventsCollectionViewController.h"

@interface NearEventsViewController ()

@property(nonatomic, weak) EventsCollectionViewController *eventsCollectionViewController;

@end

@implementation NearEventsViewController

-(void)refreshContent
{
    [self.eventsCollectionViewController refreshContent];
}


#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"NearEventsEmbedEventsCollection"])
    {
        self.eventsCollectionViewController = segue.destinationViewController;
    }
}


@end
