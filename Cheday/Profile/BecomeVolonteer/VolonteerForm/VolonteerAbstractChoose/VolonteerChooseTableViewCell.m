//
//  VolonteerAbstractChooseTableViewCell.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 17.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerChooseTableViewCell.h"

@implementation VolonteerChooseTableViewCell

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    _checkBox = (BEMCheckBox*)self.accessoryView;
    _checkBox.onAnimationType = BEMAnimationTypeBounce;
    _checkBox.offAnimationType = BEMAnimationTypeBounce;
}

-(void)dealloc
{
    self.selectableObject = nil;
}

-(void)setSelectableObject:(NSObject<Selecting> *)selectableObject
{
    [_selectableObject removeObserver:self
                           forKeyPath:@"selected"
                              context:(__bridge void * _Nullable)(self)];
    _selectableObject = selectableObject;
    [_selectableObject addObserver:self
                        forKeyPath:@"selected"
                           options:NSKeyValueObservingOptionNew
                           context:(__bridge void * _Nullable)(self)];
    
    _checkBox.on = _selectableObject.selected;
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary<NSString *,id> *)change
                      context:(void *)context
{
    if(context == (__bridge void * _Nullable)(self) && object == _selectableObject && [keyPath isEqualToString:@"selected"])
    {
        [_checkBox setOn:_selectableObject.selected animated:YES];
    }
}

-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    if(checkBox.on)
        [self.delegate volonteerChooseTableViewCellDidSelectCheckbox:self];
    else
        [self.delegate volonteerChooseTableViewCellDidDeselectCheckbox:self];
}

@end
