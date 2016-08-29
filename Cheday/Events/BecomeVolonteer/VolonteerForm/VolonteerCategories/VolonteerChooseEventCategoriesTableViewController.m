//
//  VolonteerEventCategoriesTableViewController.m
//  Cheday
//
//  Created by Andrey Krukovskiy on 11.08.16.
//  Copyright © 2016 Cheday. All rights reserved.
//

#import "VolonteerChooseEventCategoriesTableViewController.h"
#import "EventCategory+Selecting.h"

@interface VolonteerChooseEventCategoriesTableViewController ()

@end

@implementation VolonteerChooseEventCategoriesTableViewController

-(PFQuery *)query
{
    return [EventCategory query];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    EventCategory *category = _objects[indexPath.row];
    cell.textLabel.text = category.name;
    return cell;
}

@end
