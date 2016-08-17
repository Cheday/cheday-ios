//
//  VolonteerEventCategoryTableViewCell.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 17.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerEventCategoryTableViewCell.h"
#import "EventCategory+Selected.h"

@interface VolonteerEventCategoryTableViewCell ()

@end

@implementation VolonteerEventCategoryTableViewCell

-(void)dealloc
{
    self.eventCategory = nil;
}

-(void)setEventCategory:(EventCategory *)eventCategory
{
    [_eventCategory removeObserver:self
                        forKeyPath:@"selected"
                           context:(__bridge void * _Nullable)(self)];
    _eventCategory = eventCategory;
    [_eventCategory addObserver:self
                     forKeyPath:@"selected"
                        options:NSKeyValueObservingOptionNew
                        context:(__bridge void * _Nullable)(self)];
    
    _checkBox.on = _eventCategory.selected;
    self.textLabel.text = _eventCategory.name;
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change
                      context:(void *)context
{
    if(context == (__bridge void * _Nullable)(self) && object == _eventCategory && [keyPath isEqualToString:@"selected"])
    {
        [_checkBox setOn:_eventCategory.selected animated:YES];
    }
}

@end
