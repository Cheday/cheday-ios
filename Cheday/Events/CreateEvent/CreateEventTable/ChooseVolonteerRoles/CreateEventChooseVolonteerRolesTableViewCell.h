//
//  CreateEventChooseVolonteerRolesTableViewCell.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 31.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VolonteerRole+Counting.h"

@protocol CreateEventChooseVolonteerRolesTableViewCellDelegate;

@interface CreateEventChooseVolonteerRolesTableViewCell : UITableViewCell

@property(nonatomic, strong) VolonteerRole *volonteerRole;
@property(nonatomic, weak) id<CreateEventChooseVolonteerRolesTableViewCellDelegate> delegate;

@end

@protocol CreateEventChooseVolonteerRolesTableViewCellDelegate <NSObject>

-(void) createEventChooseVolonteerRolesTableViewCell:(CreateEventChooseVolonteerRolesTableViewCell*)cell didChangeVolonteerCount:(NSInteger)count;

@end
