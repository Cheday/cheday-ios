//
//  SignupViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "SignupViewController.h"
@import IQKeyboardManager;
#import "User.h"
@import CocoaLumberjack;
extern DDLogLevel ddLogLevel;

@interface SignupViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *repeatPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signupButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *signupActivityIndicator;

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

- (IBAction)onSignUpButtonTap:(UIButton *)sender {
    if(self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""])
    {
        [self showAlertWithTitle:NSLocalizedString(@"Validation", nil)
                         message:NSLocalizedString(@"Name cannot be empty", nil)];
        return;
    }
    if(self.emailTextField.text == nil || [self.emailTextField.text isEqualToString:@""])
    {
        [self showAlertWithTitle:NSLocalizedString(@"Validation", nil)
                         message:NSLocalizedString(@"Email cannot be empty", nil)];
        return;
    }
    if(self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""])
    {
        [self showAlertWithTitle:NSLocalizedString(@"Validation", nil)
                         message:NSLocalizedString(@"Password cannot be empty", nil)];
        return;
    }
    if(![self.passwordTextField.text isEqual:self.repeatPasswordTextField.text])
    {
        [self showAlertWithTitle:NSLocalizedString(@"Validation", nil)
                         message:NSLocalizedString(@"Passwords is not equal", nil)];
        return;
    }
    
    User *newUser = [User object];
    newUser.username = self.nameTextField.text;
    newUser.email = self.emailTextField.text;
    newUser.password = self.passwordTextField.text;

    self.signupButton.enabled = NO;
    [self.signupActivityIndicator startAnimating];
    DDLogDebug(@"Signing up with user: %@", newUser);
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        self.signupButton.enabled = YES;
        [self.signupActivityIndicator stopAnimating];
        if(succeeded)
        {
            DDLogDebug(@"User created: %@", [User currentUser]);
            [self.delegate signupViewControllerDidSignup:self];
        }else
        {
            [self showAlertWithTitle:NSLocalizedString(@"Error", nil)
                             message:NSLocalizedString(error.localizedDescription, nil)];
        }
    }];
}

-(void) showAlertWithTitle:(NSString*)title message:(NSString*)message
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlertController = alertController;
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Ok", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [weakAlertController dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    [self presentViewController:alertController animated:YES completion:nil];
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
