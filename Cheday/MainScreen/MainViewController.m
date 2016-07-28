//
//  MainViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 28.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "MainViewController.h"
#import "ProfileNameAndPhotoViewController.h"

@implementation MainViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"MainEmbedProfileNameAndPhoto"])
    {
        ProfileNameAndPhotoViewController *vc = segue.destinationViewController;
        vc.user = [User currentUser];
    }
}

@end
