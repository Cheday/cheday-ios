//
//  UIAlertController+SimpleAlert.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 27.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertController (SimpleAlert)

+(void) presentAlertControllerWithTitle:(NSString*)title
                                message:(NSString*)message
                     fromViewController:(UIViewController*)viewController;

@end
