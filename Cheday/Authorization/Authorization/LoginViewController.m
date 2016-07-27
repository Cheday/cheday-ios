//
//  LoginViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"

@interface LoginViewController ()
<SignupViewControllerDelegate>

@end

@implementation LoginViewController

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"LoginShowSignup"])
    {
        SignupViewController *vc = (SignupViewController*) segue.destinationViewController;
        vc.delegate = self;
    }
}

-(void)signupViewControllerDidSignup:(SignupViewController *)viewController
{
    [self.delegate loginViewControllerDidLogin:self];
}


-(IBAction) unwindFromSignupViewController:(UIStoryboardSegue*)segue
{
    
}

@end
