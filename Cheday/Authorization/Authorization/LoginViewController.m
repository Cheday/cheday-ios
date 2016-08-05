//
//  LoginViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "LoginViewController.h"
#import "SignupViewController.h"
#import "UIAlertController+SimpleAlert.h"
#import "User.h"
#import <CocoaLumberjack/CocoaLumberjack.h>
extern DDLogLevel ddLogLevel;
@import ParseTwitterUtils;
#import "ProfileUpdaterFromTwitter.h"

@interface LoginViewController ()
<SignupViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *facebookLoginButton;
@property (weak, nonatomic) IBOutlet UIButton *twitterLoginButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loginActivityIndicator;

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
- (IBAction)onLoginButtonTap:(UIButton *)sender {
    if(self.nameTextField.text == nil || [self.nameTextField.text isEqualToString:@""])
    {
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Имя не может быть пустым", nil)
                                        fromViewController:self];
        return;
    }
    
    if(self.passwordTextField.text == nil || [self.passwordTextField.text isEqualToString:@""])
    {
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Пароль не может быть пустым", nil)
                                        fromViewController:self];
        return;
    }
    
    [self disableLoginButtons];
    DDLogDebug(@"Log in with username %@ and password %@", self.nameTextField.text, self.passwordTextField.text);
    [User logInWithUsernameInBackground:self.nameTextField.text
                               password:self.passwordTextField.text
                                  block:^(PFUser * _Nullable user, NSError * _Nullable error) {
                                      [self enableLoginButtons];
                                      if(user)
                                      {
                                          DDLogDebug(@"User logged in: %@", user);
                                          [self.delegate loginViewControllerDidLogin:self];
                                      }else
                                      {
                                          [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                                                     message:error.localizedDescription
                                                                          fromViewController:self];
                                      }
    }];
}

- (IBAction)onLoginWithTwitter:(UIButton *)sender {
    [self disableLoginButtons];
    DDLogDebug(@"Log in with twitter");
    [PFTwitterUtils logInWithBlock:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if(user)
        {
            DDLogDebug(@"User logged in: %@", user);
            [ProfileUpdaterFromTwitter updateUser:(User*)user completion:^(User *user, NSError *error) {
                if(error)
                {
                    [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                               message:error.localizedDescription
                                                    fromViewController:self];
                }
                [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
                    [self enableLoginButtons];
                    if(!succeeded)
                    {
                        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                                   message:error.localizedDescription
                                                        fromViewController:self];
                    }
                    [self.delegate loginViewControllerDidLogin:self];
                }];
            }];
        }else
        {
            [self enableLoginButtons];
            [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                       message:error.localizedDescription
                                            fromViewController:self];
        }
    }];
}

- (IBAction)onLoginWithFacebook:(UIButton *)sender {
    
}

-(void)signupViewControllerDidSignup:(SignupViewController *)viewController
{
    [self.delegate loginViewControllerDidLogin:self];
}


-(IBAction) unwindFromSignupViewController:(UIStoryboardSegue*)segue
{
    
}

-(void) disableLoginButtons
{
    self.loginButton.enabled = NO;
    self.facebookLoginButton.enabled = NO;
    self.twitterLoginButton.enabled = NO;
    [self.loginActivityIndicator startAnimating];
}

-(void) enableLoginButtons
{
    self.loginButton.enabled = YES;
    self.facebookLoginButton.enabled = YES;
    self.twitterLoginButton.enabled = YES;
    [self.loginActivityIndicator stopAnimating];
}

@end
