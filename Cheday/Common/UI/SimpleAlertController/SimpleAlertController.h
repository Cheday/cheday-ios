//
//  SimpleAlertController.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 04.10.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleAlertController : UIAlertController

+(instancetype)alertControllerWithTitle:(NSString *)title message:(NSString *)message;

@end
