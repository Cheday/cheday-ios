//
//  VolonteerAbstractChooseTableViewCell.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 17.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>
@import BEMCheckBox;

@protocol VolonteerChooseTableViewCellDelegate;

@interface VolonteerChooseTableViewCell : UITableViewCell
<BEMCheckBoxDelegate>
{
    BEMCheckBox *_checkBox;
}

@property(nonatomic, weak) id<VolonteerChooseTableViewCellDelegate> delegate;

@end

@protocol VolonteerChooseTableViewCellDelegate <NSObject>

-(void) volonteerChooseTableViewCellDidSelectCheckbox:(VolonteerChooseTableViewCell*)cell;
-(void) volonteerChooseTableViewCellDidDeselectCheckbox:(VolonteerChooseTableViewCell*)cell;

@end