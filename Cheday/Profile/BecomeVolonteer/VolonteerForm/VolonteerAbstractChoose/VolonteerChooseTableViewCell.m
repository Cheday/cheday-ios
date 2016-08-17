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

-(void)didTapCheckBox:(BEMCheckBox *)checkBox
{
    if(checkBox.on)
        [self.delegate volonteerChooseTableViewCellDidSelectCheckbox:self];
    else
        [self.delegate volonteerChooseTableViewCellDidDeselectCheckbox:self];
    
}

@end
