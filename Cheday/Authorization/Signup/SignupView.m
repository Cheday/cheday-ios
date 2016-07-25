//
//  SignupView.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "SignupView.h"

@implementation SignupView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.nameTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name_icon"]];
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.emailTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"email_icon"]];
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    self.passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd_icon"]];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
    self.repeatPasswordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd_icon"]];
    self.repeatPasswordTextField.leftViewMode = UITextFieldViewModeAlways;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.nameTextField)
    {
        [self.emailTextField becomeFirstResponder];
    }
    else if (textField== self.emailTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }
    else if(textField == self.passwordTextField)
    {
        [self.repeatPasswordTextField becomeFirstResponder];
    }
    else if (textField== self.repeatPasswordTextField)
    {
        [textField resignFirstResponder];
        [self.signupButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return NO;
}

-(void)onViewTap:(id)sender
{
    [self endEditing:NO];
}


@end
