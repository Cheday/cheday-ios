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
#import "UIAlertController+SimpleAlert.h"


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
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Имя не может быть пустым", nil)
                                        fromViewController:self];
        return;
    }
    if(self.emailTextField.text == nil || [self.emailTextField.text isEqualToString:@""])
    {
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Email не может быть пустым", nil)
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
    if(![self.passwordTextField.text isEqual:self.repeatPasswordTextField.text])
    {
        [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Проверка", nil)
                                                   message:NSLocalizedString(@"Пароли не совпадают", nil)
                                        fromViewController:self];
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
            [UIAlertController presentAlertControllerWithTitle:NSLocalizedString(@"Ошибка", nil)
                                                       message:error.localizedDescription
                                            fromViewController:self];
        }
    }];
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
