//
//  VolonteerEventCategoryTableViewCell.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 17.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EventCategory.h"
#import "VolonteerChooseTableViewCell.h"

@interface VolonteerEventCategoryTableViewCell : VolonteerChooseTableViewCell

@property(nonatomic, strong) EventCategory *eventCategory;

@end

