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
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@end

@implementation CreateEventChooseVolonteerRolesTableViewCell

-(void)setVolonteerRole:(VolonteerRole *)volonteerRole
{
    _volonteerRole = volonteerRole;
    self.nameLabel.text = _volonteerRole.name;
    self.countLabel.text = [@(_volonteerRole.count) stringValue];
}

- (IBAction)stepperValueChanged:(UIStepper *)sender
{
    [self.delegate createEventChooseVolonteerRolesTableViewCell:self
                                        didChangeVolonteerCount:(NSInteger)sender.value];
}

@end
