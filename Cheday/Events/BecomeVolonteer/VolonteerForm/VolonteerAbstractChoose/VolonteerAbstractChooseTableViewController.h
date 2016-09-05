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

@protocol VolonteerChooseTableViewControllerDelegate;

@interface VolonteerAbstractChooseTableViewController : UITableViewController
<VolonteerChooseTableViewCellDelegate>
{
    NSArray *_objects;
    NSMutableSet *_selectedObjects;
}

@property(nonatomic, copy) NSMutableSet *selectedObjects;
@property(nonatomic, weak) id<VolonteerChooseTableViewControllerDelegate> delegate;

-(PFQuery*) query;

@end

@protocol VolonteerChooseTableViewControllerDelegate <NSObject>

-(void) chooseTableViewController:(VolonteerAbstractChooseTableViewController*)viewController didSelectObject:(id)object;
-(void) chooseTableViewController:(VolonteerAbstractChooseTableViewController*)viewController didDeselectObject:(id)object;

@end