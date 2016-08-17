//
//  VolonteerFormTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 10.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerFormTableViewController.h"

@implementation VolonteerFormTableViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    [segue.destinationViewController.navigationController setNavigationBarHidden:NO
                                                                        animated:YES];
}

@end
