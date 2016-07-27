//
//  LoginViewController.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LoginViewControllerDelegate;

@interface LoginViewController : UIViewController

@property(nonatomic, weak) id<LoginViewControllerDelegate> delegate;

-(IBAction) unwindFromSignupViewController:(UIStoryboardSegue*)segue;

@end


@protocol LoginViewControllerDelegate <NSObject>

-(void) loginViewControllerDidLogin:(LoginViewController*)loginViewController;

@end