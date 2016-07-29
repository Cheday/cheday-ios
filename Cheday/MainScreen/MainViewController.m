//
//  MainViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 28.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "MainViewController.h"
#import "ProfileNameAndPhotoViewController.h"

@interface MainViewController ()

@property(nonatomic, weak) ProfileNameAndPhotoViewController *profileNamAndPhotoVC;

@end

@implementation MainViewController

-(void)setUser:(User *)user
{
    _user = user;
    self.profileNamAndPhotoVC.user = user;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"MainEmbedProfileNameAndPhoto"])
    {
        self.profileNamAndPhotoVC= segue.destinationViewController;
        self.profileNamAndPhotoVC.user = self.user;
    }
}

@end
