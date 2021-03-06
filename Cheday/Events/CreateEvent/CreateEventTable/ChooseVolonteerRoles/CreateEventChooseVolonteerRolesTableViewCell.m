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
@property (weak, nonatomic) IBOutlet UIStepper *stepper;

@end

@implementation CreateEventChooseVolonteerRolesTableViewCell

-(void)dealloc
{
    self.volonteerRole = nil;
}

-(void)setVolonteerRole:(VolonteerRole *)volonteerRole
{
    [_volonteerRole removeObserver:self
                        forKeyPath:@"count"
                           context:(__bridge void * _Nullable)(self)];
    _volonteerRole = volonteerRole;
    [_volonteerRole addObserver:self
                     forKeyPath:@"count"
                        options:NSKeyValueObservingOptionNew
                        context:(__bridge void * _Nullable)(self)];
    self.nameLabel.text = _volonteerRole.name;
    self.countLabel.text = [@(_volonteerRole.count) stringValue];
    self.stepper.value = _volonteerRole.count;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if((context == (__bridge void * _Nullable)(self)) && [_volonteerRole isEqual:object] && [keyPath isEqualToString:@"count"])
    {
        self.countLabel.text = [@(_volonteerRole.count) stringValue];
        self.stepper.value = _volonteerRole.count;
    }
}

- (IBAction)stepperValueChanged:(UIStepper *)sender
{
    [self.delegate createEventChooseVolonteerRolesTableViewCell:self
                                        didChangeVolonteerCount:(NSInteger)sender.value];
}

@end
