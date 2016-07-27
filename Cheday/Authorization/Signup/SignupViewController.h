//
//  SignupViewController.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SignupViewControllerDelegate;

@interface SignupViewController : UIViewController

@property(nonatomic, weak) id<SignupViewControllerDelegate> delegate;

@end


@protocol SignupViewControllerDelegate <NSObject>

-(void) signupViewControllerDidSignup:(SignupViewController*)viewController;

@end