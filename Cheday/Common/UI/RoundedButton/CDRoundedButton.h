//
//  CDRoundedButton.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 22.07.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CDRoundedButton : UIButton

@property(nonatomic, strong) IBInspectable UIColor *highlightedBackgroundColor;
@property(nonatomic, strong) IBInspectable UIColor *disabledBackgroundColor;

@end
