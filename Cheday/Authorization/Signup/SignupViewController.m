//
//  SignupViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "SignupViewController.h"
@import IQKeyboardManager;

@interface SignupViewController ()

@end

@implementation SignupViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = YES;
    [IQKeyboardManager sharedManager].enableAutoToolbar = YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    [IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
