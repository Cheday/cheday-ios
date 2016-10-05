//
//  SimpleAlertController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 04.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "SimpleAlertController.h"

@interface SimpleAlertController ()

@end

@implementation SimpleAlertController

+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message
{
    SimpleAlertController *alertController = [self alertControllerWithTitle:title
                                                                    message:message
                                                             preferredStyle:UIAlertControllerStyleAlert];
    __weak UIAlertController *weakAlertController = alertController;
    [alertController addAction:[UIAlertAction actionWithTitle:NSLocalizedString(@"Ок", nil)
                                                        style:UIAlertActionStyleDefault
                                                      handler:^(UIAlertAction * _Nonnull action) {
                                                          [weakAlertController dismissViewControllerAnimated:YES completion:nil];
                                                      }]];
    return alertController;
}

@end
