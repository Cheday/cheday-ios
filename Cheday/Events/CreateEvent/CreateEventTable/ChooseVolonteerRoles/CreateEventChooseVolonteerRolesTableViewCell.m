//
//  CreateEventChooseVolonteerRolesTableViewCell.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 31.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "CreateEventChooseVolonteerRolesTableViewCell.h"

@interface CreateEventChooseVolonteerRolesTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation CreateEventChooseVolonteerRolesTableViewCell

-(void)setVolonteerRole:(VolonteerRole *)volonteerRole
{
    _volonteerRole = volonteerRole;
    self.nameLabel.text = _volonteerRole.name;
}

@end
