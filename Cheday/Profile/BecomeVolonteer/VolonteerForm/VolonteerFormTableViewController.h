//
//  VolonteerFormTableViewController.h
//  Cheday
//
//  Created by Andrey Krukovskiy on 10.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VolonteerFormTableViewControllerDelegate;

@interface VolonteerFormTableViewController : UITableViewController

@property(nonatomic, weak) id<VolonteerFormTableViewControllerDelegate> delegate;

@end

@protocol VolonteerFormTableViewControllerDelegate <NSObject>

-(void) volonteerFromTVCDidSelectCategories:(VolonteerFormTableViewController*)volonteerTVC;
-(void) volonteerFromTVCDidSelectRoles:(VolonteerFormTableViewController*)volonteerTVC;
-(void) volonteerFromTVCDidSelectDates:(VolonteerFormTableViewController*)volonteerTVC;

@end