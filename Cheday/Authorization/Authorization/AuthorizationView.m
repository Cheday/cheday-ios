//
//  AuthorizationView.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "AuthorizationView.h"

@implementation AuthorizationView

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.nameTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"name_icon"]];
    self.nameTextField.leftViewMode = UITextFieldViewModeAlways;
    self.passwordTextField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pwd_icon"]];
    self.passwordTextField.leftViewMode = UITextFieldViewModeAlways;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if(textField == self.nameTextField)
    {
        [self.passwordTextField becomeFirstResponder];
    }else if (textField== self.passwordTextField)
    {
        [textField resignFirstResponder];
        [self.loginButton sendActionsForControlEvents:UIControlEventTouchUpInside];
    }
    return NO;
}

-(void)onViewTap:(id)sender
{
    [self endEditing:NO];
}

@end
