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

@interface LoginViewController ()
<SignupViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
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
    
    self.loginButton.enabled = NO;
    [self.loginActivityIndicator startAnimating];
    DDLogDebug(@"Log in with username %@ and password %@", self.nameTextField.text, self.passwordTextField.text);
    [User logInWithUsernameInBackground:self.nameTextField.text
                               password:self.passwordTextField.text
                                  block:^(PFUser * _Nullable user, NSError * _Nullable error) {
                                      self.loginButton.enabled = YES;
                                      [self.loginActivityIndicator stopAnimating];
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

-(void)signupViewControllerDidSignup:(SignupViewController *)viewController
{
    [self.delegate loginViewControllerDidLogin:self];
}


-(IBAction) unwindFromSignupViewController:(UIStoryboardSegue*)segue
{
    
}

@end
