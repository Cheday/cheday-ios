//
//  VolonteerAbstractChooseTableViewController.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 12.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>
@import Parse;
#import "VolonteerChooseTableViewCell.h"

@interface VolonteerAbstractChooseTableViewController : UITableViewController
<VolonteerChooseTableViewCellDelegate>
{
    NSArray *_objects;
    NSMutableSet *_selectedObjects;
}

@property(nonatomic, strong) NSMutableSet *selectedObjects;

-(PFQuery*) query;

@end
