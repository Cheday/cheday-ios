//
//  UIAlertController+SimpleAlert.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 27.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "UIAlertController+SimpleAlert.h"

@implementation UIAlertController (SimpleAlert)

+(void)presentAlertControllerWithTitle:(NSString *)title message:(NSString *)message fromViewController:(UIViewController *)viewController
{
    if(viewController.parentViewController || viewController.presentingViewController)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                                 message:message
                                                                          preferredStyle:UIAlertControllerStyleAlert];
        __weak UIAlertController *weakAlertController = alertController;
        [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Ок", nil)
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              [weakAlertController dismissViewControllerAnimated:YES completion:nil];
                                                          }]];
        [viewController presentViewController:alertController animated:YES completion:nil];
    }
}

@end
